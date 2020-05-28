abstract class Mapper<P, R> {
  R map(P param);

  List<R> mapList(List<P> params) => params.map((P param) => map(param));
}
