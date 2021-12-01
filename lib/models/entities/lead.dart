enum LeadView {
  approval,
  followUp,
  appraisal,
  dispatched,
  active,
  completed
}

extension LeadViewExt on LeadView {
  String getName() {
    switch (this) {
      case LeadView.approval:
        return 'Awaiting Approval';
      case LeadView.followUp:
        return 'Follow Up';
      case LeadView.appraisal:
        return 'Appraisal';
      case LeadView.dispatched:
        return 'Dispatched';
      case LeadView.active:
        return 'In Progress';
      case LeadView.completed:
        return 'Completed';
    }
  }
}