const std = @import("std");

pub fn cpkgInit() !void {
    const dirName = "cpkgExternal";
    try std.fs.cwd().makeDir(dirName);
}
