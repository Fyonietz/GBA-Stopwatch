const std = @import("std");


pub fn build (b:*std.Build) void{
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .thumb,
        .os_tag = .freestanding,
        .abi = .eabi,
        .cpu_model = .{.explicit = &std.Target.arm.cpu.arm7tdmi},
    });

    const optimize = b.standardOptimizeOption(.{ .preferred_optimize_mode = .ReleaseSmall });

    //Elf
    const elf = b.addExecutable(.{
        .name = "game",
        .root_module = b.createModule(.{
          .root_source_file = b.path("src/main.zig"),
          .target = target,
          .optimize = optimize
        })
    });

    //React handler assembly
    elf.root_module.addAssemblyFile(b.path("src/crt0.s"));

    //Linker
    elf.setLinkerScript(b.path("src/linker.ld"));
    elf.entry = .{.symbol_name = "_start"};

    //Obj Copy 
    const objcopy = b.addObjCopy(elf.getEmittedBin(),.{
        .format = .bin,
        .basename = "game.gba",
    });

    const install = b.addInstallBinFile(objcopy.getOutput(),"game.gba");

    b.default_step.dependOn(&install.step);

    //Gba Fix Step
    const gba_output = b.getInstallPath(.bin,"game.gba");
    const gbafix = b.addSystemCommand(&.{"gbafix",gba_output});
    gbafix.step.dependOn(&install.step);

    const fix_step = b.step("Fix", "Build and Patch ROM Header");
    fix_step.dependOn(&gbafix.step);

    //Run MGBA
    const mgba = b.addSystemCommand(&.{"mgba-qt",gba_output});
    mgba.step.dependOn(&gbafix.step);

    const run_step = b.step("run","Build and Launch");
    run_step.dependOn(&mgba.step);
}
