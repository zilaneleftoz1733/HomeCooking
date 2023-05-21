
import 'package:projectmanagement/navigation/navigation_view_model.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<NavigationViewModel>(
    create: (context) => NavigationViewModel(),
  ),

  
];
