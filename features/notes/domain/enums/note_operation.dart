enum NoteOperation {
  create,
  update;

  bool get isCreate => this == NoteOperation.create;
  bool get isUpdate => this == NoteOperation.update;
}