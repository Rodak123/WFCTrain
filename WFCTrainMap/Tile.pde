class Tile {

  PImage img;
  String[] edges;

  int[] up, down, left, right;

  Tile(PImage img, String edges) {
    this(img, edges.split(","));
  }

  Tile(PImage img, String[] edges) {
    this.img = img;
    this.edges = edges;
  }

  void analyze(Tile[] tiles) {
    IntList up = new IntList();
    IntList down = new IntList();
    IntList left = new IntList();
    IntList right = new IntList();
    for (int i=0; i<tiles.length; i++) {
      Tile tile = tiles[i];

      if (sameEdge(tile, 0))
        up.append(i);

      if (sameEdge(tile, 1))
        right.append(i);

      if (sameEdge(tile, 2))
        down.append(i);

      if (sameEdge(tile, 3))
        left.append(i);
    }
    this.up = up.array();
    this.right = right.array();
    this.down = down.array();
    this.left = left.array();
  }

  boolean sameEdge(Tile other, int edge) {
    return edges[edge].equals(other.edges[invertEdge(edge)]);
  }

  int invertEdge(int edge) {
    return (edge+2)%4;
  }

  Tile rotate(int num) {
    int w = img.width;
    int h = img.height;
    PGraphics newImg = createGraphics(w, h);
    newImg.beginDraw();
    newImg.imageMode(CENTER);
    newImg.translate(w*0.5, h*0.5);
    newImg.rotate(HALF_PI * num);
    newImg.image(img, 0, 0);
    newImg.endDraw();

    String[] newEdges = new String[4];
    for (int i=0; i<edges.length; i++)
      newEdges[i] = edges[(i-num+edges.length) % edges.length];
    return new Tile(newImg.get(), newEdges);
  }
}
