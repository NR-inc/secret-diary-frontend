class FirestoreKeys {
  static const usersCollectionKey = 'users';
  static const postsCollectionKey = 'posts';
  static const likesCollectionKey = 'likes';
  static const commentsCollectionKey = 'comments';

  /// USERS
  static const firstNameFieldKey = 'first_name';
  static const lastNameFieldKey = 'last_name';
  static const emailFieldKey = 'email';
  static const avatarFieldKey = 'avatar';

  /// POSTS
  static const titleFieldKey = 'title';
  static const descriptionFieldKey = 'description';
  static const visibilityFlagFieldKey = 'visibility_flag';
  static const likesFieldKey = 'likes';
  static const commentsFieldKey = 'comments';
  static const createdAtFieldKey = 'created_at';
  static const authorIdFieldKey = 'author_id';
  static const postIdFieldKey = 'post_id';
  static const messageFieldKey = 'message';
  static const isLikedFieldKey = 'is_liked';
  static const isOwnerFieldKey = 'is_owner';

  /// FIREBASE ERROR CODES
  static const requiresResentLoginError = 'requires-recent-login';
  static const wrongPasswordError = 'wrong-password';
  static const toManyRequestsError = 'too-many-requests';

  /// STORAGE
  static String generateAvatarPath(String uid) {
    return 'avatar/avatar_$uid.png';
  }
}
