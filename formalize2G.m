function MG_out = formalize2G( MG, G )

MG_intern = MG;

MG_intern.horizon = G.horizon;

num = 1/MG_intern.timespan;
MG_intern.x = sum( reshape(MG_intern.x, num, []), 1) .* MG_intern.timespan;
MG_intern = shapeResults(MG_intern);

MG_out = MG;
MG_out.result2G = MG_intern.result;
MG_out.horizon2G = MG_intern.horizon;

end

