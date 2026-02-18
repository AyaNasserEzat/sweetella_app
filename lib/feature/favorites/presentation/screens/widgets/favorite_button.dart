import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favories_state.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favorites_cubit.dart';

class FavoriteButton extends StatelessWidget {
  final String productId;

  const FavoriteButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
   // print('build all favorite button');
    return BlocSelector<FavoritesCubit, FavoriesState, bool>(
      selector: (state) {
         print(state);
        if (state is FavoriesLoaded) {
          return state.favoritesIds.contains(productId);
        }
        return false;
        // return
        // context
        //     .read<FavoritesCubit>()
        //     .isFavorite(productId: productId);
      },
      builder: (context, isFav) {
        print('build icon button ${productId}');
        return IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            context.read<FavoritesCubit>().toogleFavorite(productId: productId);
          },
        );
      },
    );
  }
}

// class FavoriteButton extends StatelessWidget {
//   final String productId;

//   const FavoriteButton({super.key, required this.productId});

//   @override
//   Widget build(BuildContext context) {
//print('build all favorite button');
//     return BlocBuilder<FavoritesCubit, FavoriesState>(
//       builder: (context, state) {
//         print('build icon button ${productId}');
//         print(state);
//         final isFav = BlocProvider.of<FavoritesCubit>(context).isFavorite(
//           productId: productId,
//         );

//         return IconButton(
//           icon: Icon(
//             isFav ? Icons.favorite : Icons.favorite_border,
//             color: Colors.red,
//           ),
//           onPressed: () {
//             BlocProvider.of<FavoritesCubit>(context).toogleFavorite(productId: productId);
//           },
//         );
//       },
//     );
//   }
// }
