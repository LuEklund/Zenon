pub const Parallax = @This();

const std = @import("std");
const rl = @import("raylib");

backgrounds: [3]rl.Texture2D,
scrollings: [3]f32,

pub fn init(self: *Parallax) void {
    inline for (0..3) |i| {
        self.backgrounds[i] = rl.LoadTexture(std.fmt.comptimePrint("assets/bg{d}.png", .{i + 1}));
        self.scrollings[i] = 0;
    }
}

pub fn deinit(self: *Parallax) void {
    for (self.backgrounds) |texture| {
        rl.UnloadTexture(texture);
    }
}

pub fn update(self: *Parallax) void {
    for (&self.scrollings, self.backgrounds, 0..3) |*scroll, background, i| {
        scroll.* -= (0.01 + 0.05 * @as(f32, @floatFromInt(i)));
        const width = @as(f32, @floatFromInt(background.width));
        // const heigth = @as(f32, @floatFromInt(background.height));
        if (scroll.* <= -width) scroll.* += width;
        rl.DrawTextureEx(
            background,
            .{ .x = -scroll.*, .y = 20 },
            0,
            1,
            rl.WHITE,
        );
        rl.DrawTextureEx(
            background,
            .{ .x = -(scroll.* + width), .y = 20 },
            0,
            1,
            rl.WHITE,
        );
    }
}
