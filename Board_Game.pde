class Vector { int x, y; Vector(int x, int y) { this.x = x; this.y = y; } }

Camera Camera;
Board Board;
SideMenu SideMenu;

void setup() {
    size(1000, 700);
    frameRate(1000); // High framerate allows for smooth dragging

    Camera = new Camera();
    Board = new Board(new Vector(20, 20));
    SideMenu = new SideMenu(new Vector((Board.pos.x*2)+Board.size.x, Board.pos.y),
                            new Vector(width-(Board.pos.x*3)-Board.size.x,
                                       Board.size.y));
    
    Board.tiles[0][0].test_add_500();
}

void draw() {
    background(0);

    Camera.render_all();
    if (Mouse.isHeld && Mouse.clickedOnMap) {
        Camera.update_offset();
    }
}

class Camera {
    Vector camera_offset = new Vector(0, 0);

    void render_all() {
        this.render_board();
        this.render_sidemenu();
    }

    void render_board() {
        Board.render();
    }

    void render_sidemenu() {
        SideMenu.render();
    }

    void update_offset() {
        if (Mouse.start_pos != null) {
            Vector new_pos = new Vector(mouseX, mouseY);
            Vector diff = new Vector(Mouse.start_pos.x-new_pos.x,
                                     Mouse.start_pos.y-new_pos.y);
            this.camera_offset.x -= diff.x;
            this.camera_offset.y -= diff.y;
            Mouse.start_pos = new_pos;
            // println(this.camera_offset.x + ":" + this.camera_offset.y);
        }
    }
}

class Button {
    Vector pos, size;
    String id;
    Button(String id, Vector pos, Vector size) {
        this.id   = id;
        this.pos  = pos;
        this.size = size;
    }

    Boolean testClick(Vector mpos) {
        return (mpos.x >= this.pos.x && mpos.x <= this.pos.x+this.size.x
            &&  mpos.y >= this.pos.y && mpos.y <= this.pos.y+this.size.y);
    }
}

class Board {
    Vector pos        = new Vector(50, 50),
           size       = new Vector(height-100, height-100),
           tile_size  = new Vector(50, 50),
           enemy_size = new Vector(10, 10),
           map_size;

    class Board_Tile {

        void test_add_500() {
            // Test
            int i = 0;
            while (i < 500) {
                int x = floor(random(0, Board.map_size.x));
                int y = floor(random(0, Board.map_size.y));
                if (Board.tiles[x][y].npcs.size() < 3) {
                    Board.tiles[x][y].npcs.add(
                        new Enemy(new Vector(x, y), "Enemy " + i, floor(random(1, 100)))
                    );
                    ++i;
                } else { }
            }
        }

        class BaseNPC {
            Vector arr_pos;
            int hp_max, hp;
            String name = "",
                   type = "";

            BaseNPC(Vector arr_pos, String name, int hp_max) {
                this.arr_pos = arr_pos;
                this.name    = name;
                this.hp_max  = hp_max;
                this.hp      = this.hp_max;
            }

            Boolean isDead() { return !(this.hp > 0); }

            void render_center(Vector camera_offset) {
                switch(this.type) {
                case "Enemy":
                    fill(255, 100, 100);
                    break;
                default:
                    fill(255);
                    break;
                } noStroke();
                rectMode(CENTER);
                    rect((this.arr_pos.x*Board.tile_size.x)+Board.pos.x+camera_offset.x+floor(Board.tile_size.x/2),
                         (this.arr_pos.y*Board.tile_size.y)+Board.pos.y+camera_offset.y+floor(Board.tile_size.y/2),
                         Board.enemy_size.x,
                         Board.enemy_size.y);
                rectMode(CORNER);
            }

            void render_2_l(Vector camera_offset) {
                switch(this.type) {
                case "Enemy":
                    fill(255, 100, 100);
                    break;
                default:
                    fill(255);
                    break;
                } noStroke();
                rectMode(CENTER);
                    rect((this.arr_pos.x*Board.tile_size.x)+Board.pos.x+camera_offset.x+floor(Board.tile_size.x/4),
                         (this.arr_pos.y*Board.tile_size.y)+Board.pos.y+camera_offset.y+floor(Board.tile_size.y/2),
                         Board.enemy_size.x,
                         Board.enemy_size.y);
                rectMode(CORNER);
            }
            void render_2_r(Vector camera_offset) {
                switch(this.type) {
                case "Enemy":
                    fill(255, 100, 100);
                    break;
                default:
                    fill(255);
                    break;
                } noStroke();
                rectMode(CENTER);
                    rect((this.arr_pos.x*Board.tile_size.x)+Board.pos.x+camera_offset.x+(floor(Board.tile_size.x/4)*3),
                         (this.arr_pos.y*Board.tile_size.y)+Board.pos.y+camera_offset.y+floor(Board.tile_size.y/2),
                         Board.enemy_size.x,
                         Board.enemy_size.y);
                rectMode(CORNER);
            }

            void render_3_t(Vector camera_offset) {
                switch(this.type) {
                case "Enemy":
                    fill(255, 100, 100);
                    break;
                default:
                    fill(255);
                    break;
                } noStroke();
                rectMode(CENTER);
                    rect((this.arr_pos.x*Board.tile_size.x)+Board.pos.x+camera_offset.x+floor(Board.tile_size.x/2),
                         (this.arr_pos.y*Board.tile_size.y)+Board.pos.y+camera_offset.y+floor(Board.tile_size.y/4),
                         Board.enemy_size.x,
                         Board.enemy_size.y);
                rectMode(CORNER);
            }
            void render_3_l(Vector camera_offset) {
                switch(this.type) {
                case "Enemy":
                    fill(255, 100, 100);
                    break;
                default:
                    fill(255);
                    break;
                } noStroke();
                rectMode(CENTER);
                    rect((this.arr_pos.x*Board.tile_size.x)+Board.pos.x+camera_offset.x+floor(Board.tile_size.x/4),
                         (this.arr_pos.y*Board.tile_size.y)+Board.pos.y+camera_offset.y+(floor(Board.tile_size.y/4)*3),
                         Board.enemy_size.x,
                         Board.enemy_size.y);
                rectMode(CORNER);
            }
            void render_3_r(Vector camera_offset) {
                switch(this.type) {
                case "Enemy":
                    fill(255, 100, 100);
                    break;
                default:
                    fill(255);
                    break;
                } noStroke();
                rectMode(CENTER);
                    rect((this.arr_pos.x*Board.tile_size.x)+Board.pos.x+camera_offset.x+(floor(Board.tile_size.x/4)*3),
                         (this.arr_pos.y*Board.tile_size.y)+Board.pos.y+camera_offset.y+(floor(Board.tile_size.y/4)*3),
                         Board.enemy_size.x,
                         Board.enemy_size.y);
                rectMode(CORNER);
            }
        }

        class Enemy extends BaseNPC {
            Enemy(Vector arr_pos, String name, int hp_max) {
                super(arr_pos, name, hp_max);
                this.type = "Enemy";
            }
        }

        Vector arr_pos, render_pos;

        ArrayList<BaseNPC> npcs = new ArrayList<BaseNPC>();
        
        Board_Tile(Vector pos, Vector offset, Vector size) {
            this.arr_pos = pos;
            this.render_pos = new Vector(pos.x*size.x, pos.y*size.y);
            this.render_pos.x += offset.x;
            this.render_pos.y += offset.y;
        }

        void render(Vector camera_offset) {
            // Limits rendering inside of display area
            if (this.render_pos.x+camera_offset.x <= Board.pos.x+Board.size.x
            &&  this.render_pos.x+Board.tile_size.x+camera_offset.x >= Board.pos.x
            &&  this.render_pos.y+camera_offset.y <= Board.pos.y+Board.size.y
            &&  this.render_pos.y+Board.tile_size.y+camera_offset.y >= Board.pos.y) {
                fill(0); stroke(255);
                rect(this.render_pos.x+camera_offset.x,
                    this.render_pos.y+camera_offset.y,
                    Board.tile_size.x,
                    Board.tile_size.y);
                for (int i = this.npcs.size()-1; i >= 0 ; --i) {
                    BaseNPC npc = this.npcs.get(i);
                    if (npc.isDead()) {
                        this.npcs.remove(npc);
                    }
                }
                switch (this.npcs.size()) {
                case 0: break;
                case 1:
                    this.npcs.get(0).render_center(camera_offset);
                    break;
                case 2:
                    this.npcs.get(0).render_2_l(camera_offset);
                    this.npcs.get(1).render_2_r(camera_offset);
                    break;
                default:
                    this.npcs.get(0).render_3_t(camera_offset);
                    this.npcs.get(1).render_3_l(camera_offset);
                    this.npcs.get(2).render_3_r(camera_offset);
                    break;
                }
            }
        }

        void add_enemy(String name, int max_hp) {
            println("Adding Enemy '" + name + "' @ ("+ this.arr_pos.x + " " + this.arr_pos.y +")");
            this.npcs.add(
                new Enemy(new Vector(this.arr_pos.x, this.arr_pos.y), name, max_hp)
            );
        }
    }

    Board_Tile[][] tiles;

    Board(Vector map_size) {
        this.map_size = map_size;
        this.tiles = new Board_Tile[this.map_size.x][this.map_size.y];
        for (int i = 0; i < this.map_size.x; ++i) { for (int j = 0; j < this.map_size.y; ++j) {
            tiles[i][j] = new Board_Tile(
                new Vector(i, j),
                this.pos,
                this.tile_size
            );
        } }
    }

    void render() {
        for (Board_Tile[] btarr : this.tiles) { for (Board_Tile bt : btarr) {
            bt.render(Camera.camera_offset);
        } }

        // Border - Hides overflow of board
        fill(0); stroke(0);
        rect(0, 0, this.pos.x, height);
        rect(this.pos.x, 0, this.size.x, this.pos.y);
        rect(this.pos.x, this.pos.y+this.size.y, this.size.x, this.pos.y);
        rect(this.pos.x+this.size.x, 0, width-this.pos.x-this.size.x, height);

        noFill(); stroke(255);
        rect(this.pos.x, this.pos.y, this.size.x, this.size.y);
    }
}

class SideMenu {
    ArrayList<Board.Board_Tile.BaseNPC> selected_npc_arr = new ArrayList<Board.Board_Tile.BaseNPC>();
    Board.Board_Tile.BaseNPC selected_npc = null;
    int selected_npc_arr_index;
    Boolean showArrows = false;

    Vector pos, size;
    ArrayList<Button> buttons;
    int hpbar_size;

    SideMenu(Vector pos, Vector size) {
        this.pos = pos;
        this.size = size;

        this.hpbar_size = this.size.x-75;

        this.buttons = new ArrayList<Button>();
        this.buttons.add(new Button(
            "B_Arrow_Left",
            new Vector(this.pos.x+10, this.pos.y+this.size.y-50),
            new Vector(20, 40)
        ));
        this.buttons.add(new Button(
            "B_Arrow_Right",
            new Vector(this.pos.x+this.size.x-30, this.pos.y+this.size.y-50),
            new Vector(20, 40)
        ));
    }

    void render() {
        if (this.selected_npc_arr != null) {
            // RENDER
            // Is not affected by camera offset
            fill(0); stroke(255);
            rect(this.pos.x, this.pos.y, this.size.x, this.size.y);

            int yOffset;
            if (this.selected_npc_arr.size() <= 0) {
                stroke(255); fill(255); textAlign(CENTER); textSize(28); yOffset = 28;
                text("Empty Tile", this.pos.x+floor(this.size.x/2), this.pos.y + yOffset);
            } else {
                this.selected_npc = this.selected_npc_arr.get(this.selected_npc_arr_index);

                stroke(255); fill(255); textAlign(CENTER);
                switch(this.selected_npc.name) {
                    default: textSize(28); yOffset = 28; break;
                }
                text(this.selected_npc.name, this.pos.x+floor(this.size.x/2), this.pos.y + yOffset);

                // Image/Block Of NPC
                noStroke();
                switch(this.selected_npc.type) {
                case "Enemy":
                    fill(255, 100, 100);
                    rect(this.pos.x+50, this.pos.y + yOffset + 25, this.size.x-100, this.size.x-100);
                    break;
                }

                // HP bar
                textAlign(RIGHT);
                    textSize(16); fill(255); stroke(255);
                    text("Hp:", this.pos.x+45, this.pos.y+yOffset+this.size.x-40);
                    fill(255, 0, 0); noStroke();
                textAlign(LEFT);
                    textSize(14);
                    text(this.selected_npc.hp + "/" + this.selected_npc.hp_max,
                         this.pos.x+45, this.pos.y+yOffset+this.size.x-40);

                if (this.showArrows) {
                    // Render Arrows
                    stroke(255); fill(255);
                    triangle(this.pos.x+10, this.pos.y+this.size.y-30,
                             this.pos.x+30, this.pos.y+this.size.y-50,
                             this.pos.x+30, this.pos.y+this.size.y-10);
                    triangle(this.pos.x+this.size.x-10, this.pos.y+this.size.y-30,
                             this.pos.x+this.size.x-30, this.pos.y+this.size.y-50,
                             this.pos.x+this.size.x-30, this.pos.y+this.size.y-10);
                }
            }
        }
    }

    void pressButton(String id) {
        switch(id) {
        case "B_Arrow_Left":
            --this.selected_npc_arr_index;
            if (this.selected_npc_arr_index < 0)
                this.selected_npc_arr_index = 0;
            if (this.selected_npc_arr_index >= this.selected_npc_arr.size())
                this.selected_npc_arr_index = this.selected_npc_arr.size()-1;
            break;
        case "B_Arrow_Right":
            ++this.selected_npc_arr_index;
            if (this.selected_npc_arr_index < 0)
                this.selected_npc_arr_index = 0;
            if (this.selected_npc_arr_index >= this.selected_npc_arr.size())
                this.selected_npc_arr_index = this.selected_npc_arr.size()-1;
            break;
        }
    }
}

static class Mouse {
    static Vector  start_pos,
                   board_pos;
    static Boolean isHeld = false,
                   clickedOnMap = false;
}

void mousePressed() {
    switch(mouseButton) {
    case LEFT:
        Mouse.isHeld = true;
        Mouse.start_pos = new Vector(mouseX, mouseY);
        if (mouseX >= Board.pos.x && mouseX <= Board.pos.x+Board.size.x
        &&  mouseY >= Board.pos.y && mouseY <= Board.pos.y+Board.size.y) {
            Mouse.board_pos = new Vector(floor((mouseX-Board.pos.x-Camera.camera_offset.x)/Board.tile_size.x),
                                     floor((mouseY-Board.pos.x-Camera.camera_offset.y)/Board.tile_size.y));
            println("board_pos : " + Mouse.board_pos.x + " " + Mouse.board_pos.y);

            // Board Buttons/Interactions
            Mouse.clickedOnMap = true;

            if (Mouse.board_pos.x >= 0 && Mouse.board_pos.x < Board.map_size.x
            &&  Mouse.board_pos.y >= 0 && Mouse.board_pos.y < Board.map_size.y) {
                SideMenu.selected_npc_arr_index = 0;
                SideMenu.selected_npc_arr = Board.tiles[Mouse.board_pos.x][Mouse.board_pos.y].npcs;
                SideMenu.showArrows = SideMenu.selected_npc_arr.size() > 1 ? true : false;
            }
        }

        if (mouseX >= SideMenu.pos.x && mouseX <= SideMenu.pos.x + SideMenu.size.x
        && mouseY >= SideMenu.pos.y && mouseY <= SideMenu.pos.y + SideMenu.size.y) {
            // SideMenu Buttons/Interactions
            for (Button b : SideMenu.buttons) {
                if (b.testClick(Mouse.start_pos)) {
                    println(b.id + " Clicked");
                    SideMenu.pressButton(b.id);
                }
            }
        }
    }
}

void mouseReleased() {
    switch(mouseButton) {
    case LEFT:
        Mouse.isHeld = false;
        Mouse.clickedOnMap = false;
        Mouse.start_pos = null;
    }
}

void keyPressed() {
    try {
        Board.tiles[Mouse.board_pos.x][Mouse.board_pos.y].npcs.get(0).hp -= 25;
    } catch(IndexOutOfBoundsException ex) {}
}
