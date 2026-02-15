import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favories_state.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favorites_cubit.dart';
class FavoriteButton extends StatelessWidget {
  final String productId;

  const FavoriteButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoritesCubit, FavoriesState, bool>(
      selector: (state) {
        return context
            .read<FavoritesCubit>()
            .isFavorite(productId: productId);
      },
      builder: (context, isFav) {
        return IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            context
                .read<FavoritesCubit>()
                .toogleFavorite(productId: productId);
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
//     return BlocBuilder<FavoritesCubit, FavoriesState>(
//       builder: (context, state) {
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


