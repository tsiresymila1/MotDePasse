abstract class LoadingEvent {}

class UpdateLoadingEvent extends LoadingEvent {
  final bool isLoading ;
  UpdateLoadingEvent({required this.isLoading});
}