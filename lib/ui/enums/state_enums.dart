enum Status{
  ready,
  error, 
  success,
  loading;


  bool get isLoading{
    return this == Status.loading;
  }
  bool get hasBeenSuccesful{
    return this == Status.success;
  }
}