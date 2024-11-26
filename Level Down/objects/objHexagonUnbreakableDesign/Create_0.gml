// Randomly select a sprite between sprHexagonUnbreakableDesign(1) and sprHexagonUnbreakableDesign(11)
var random_sprite;

if (random_range(-4, 1) > 0)
{
	random_sprite = choose(sprHexagonUnbreakableDesign__1_,
		sprHexagonUnbreakableDesign__2_, 
		sprHexagonUnbreakableDesign__3_,
		sprHexagonUnbreakableDesign__4_, 
		sprHexagonUnbreakableDesign__5_, 
		sprHexagonUnbreakableDesign__6_,
        sprHexagonUnbreakableDesign__7_, 
		sprHexagonUnbreakableDesign__7_, 
		sprHexagonUnbreakableDesign__8_,
        sprHexagonUnbreakableDesign__9_, 
		sprHexagonUnbreakableDesign__10_, 
		sprHexagonUnbreakableDesign__11_,
		sprHexagonUnbreakableDesign__12_,
		sprHexagonUnbreakableDesign__13_, 
		sprHexagonUnbreakableDesign__14_,
		sprHexagonUnbreakableDesign__15_,
		sprHexagonUnbreakableDesign__16_,
		sprHexagonUnbreakableDesign__17_, 
		sprHexagonUnbreakableDesign__18_,
	);
} 
else
{
	random_sprite = sprHexagonUnbreakable
}
// Set the sprite to the randomly chosen one
sprite_index = random_sprite;
