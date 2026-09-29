const std = @import("std");
const rl = @import("raylib");
const Camera = @import("Camera.zig");

const Parallax = @import("Parallax.zig");

pub const width: u32 = 1500;
pub const height: u32 = 900;

pub fn main() !void {
    rl.SetTraceLogLevel(rl.LOG_WARNING);
    rl.SetConfigFlags(rl.FLAG_WINDOW_RESIZABLE | rl.FLAG_MSAA_4X_HINT);
    rl.InitWindow(width, height, "Zenon");
    defer rl.CloseWindow();

    var camera: Camera = .init(@splat(0));
    var parallax: Parallax = undefined;
    parallax.init();

    while (!rl.WindowShouldClose()) {
        const dt = rl.GetFrameTime();

        camera.update(dt);

        rl.BeginDrawing();
        defer rl.EndDrawing();

        rl.ClearBackground(rl.PINK);
        parallax.update();

        rl.BeginMode2D(camera.toRaylib());
        defer rl.EndMode2D();

        // rl.DrawRectangleV(
        //     .{ .x = -100.0, .y = -0.5 },
        //     .{ .x = 200.0, .y = 0.5 },
        //     rl.LIME,
        // );
        //
        // rl.DrawCircleV(
        //     .{
        //         .x = 0.0,
        //         .y = -0.5,
        //     },
        //     0.25,
        //     rl.RED,
        // );

    }
}
