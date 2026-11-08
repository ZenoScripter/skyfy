/*
 *     Copyright (C) 2026 Valeri Gokadze
 *
 *     Musify is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     (at your option) any later version.
 *
 *     Musify is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 *
 *     You should have received a copy of the GNU General Public License
 *     along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *
 *     For more information about Musify, including how to contribute,
 *     please visit: https://github.com/gokadzev/Musify
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:musify/services/profile_manager.dart';
import 'package:musify/utilities/platform_utils.dart';
import 'package:musify/utilities/skyfy_text.dart';
import 'package:musify/widgets/mini_player_bottom_space.dart';
import 'package:musify/widgets/skyfy_backdrop.dart';
import 'package:musify/widgets/skyfy_widgets.dart';

/// "Profile" tab: avatar, name and shortcuts to the other settings screens.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final topInset = MediaQuery.paddingOf(context).top;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            const Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: SkyfyBackdrop(height: 340),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, topInset + 12, 20, 12),
              child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: tt('Pengaturan', 'Settings'),
                      onPressed: () => context.push('/settings/preferences'),
                      icon: const Icon(FluentIcons.settings_24_regular),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SkyfyAvatar(
                  size: 116,
                  showEditBadge: true,
                  onBadgeTap: () => context.push('/settings/edit-profile'),
                ),
                const SizedBox(height: 14),
                ValueListenableBuilder<String>(
                  valueListenable: profileName,
                  builder: (context, name, _) => Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                SkyfyMenuTile(
                  icon: FluentIcons.person_24_regular,
                  title: tt('Edit Profil', 'Edit Profile'),
                  subtitle: tt('Ubah nama dan foto', 'Change name and photo'),
                  onTap: () => context.push('/settings/edit-profile'),
                ),
                SkyfyMenuTile(
                  icon: FluentIcons.color_24_regular,
                  title: 'Appearance',
                  subtitle: tt(
                    'Tema, warna, dan tampilan',
                    'Theme, colors and look',
                  ),
                  onTap: () => context.push('/settings/theme'),
                ),
                if (isAndroidPlatform)
                  SkyfyMenuTile(
                    icon: FluentIcons.data_histogram_24_regular,
                    title: 'Equalizer',
                    subtitle: tt(
                      'Atur suara sesuai seleramu',
                      'Shape the sound your way',
                    ),
                    onTap: () => context.push('/settings/equalizer'),
                  ),
                SkyfyMenuTile(
                  icon: FluentIcons.info_20_regular,
                  title: tt('Tentang Skyfy', 'About Skyfy'),
                  subtitle: tt(
                    'Informasi aplikasi dan developer',
                    'App information and developer',
                  ),
                  onTap: () => context.push('/settings/about'),
                ),
                const MiniPlayerBottomSpace(),
              ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
