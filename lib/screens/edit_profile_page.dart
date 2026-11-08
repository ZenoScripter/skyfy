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
import 'package:musify/utilities/flutter_toast.dart';
import 'package:musify/utilities/playlist_image_picker.dart';
import 'package:musify/utilities/skyfy_text.dart';
import 'package:musify/widgets/skyfy_widgets.dart';

/// Edit the display name and the profile photo.
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nameController = TextEditingController(
    text: profileName.value,
  );
  String? _image = profileImage.value;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final picked = await pickImage();
    if (picked == null || !mounted) return;
    setState(() => _image = picked);
  }

  Future<void> _save() async {
    await saveProfile(name: _nameController.text, image: _image);
    if (!mounted) return;
    showToast(context, tt('Profil disimpan', 'Profile saved'));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(tt('Edit Profil', 'Edit Profile')),
        leading: IconButton(
          icon: const Icon(FluentIcons.arrow_left_24_regular),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickPhoto,
                child: SkyfyAvatar(
                  size: 128,
                  showEditBadge: true,
                  useOverride: true,
                  imageOverride: _image,
                  onBadgeTap: _pickPhoto,
                ),
              ),
            ),
            if (_image != null)
              Center(
                child: TextButton(
                  onPressed: () => setState(() => _image = null),
                  child: Text(
                    tt('Hapus foto', 'Remove photo'),
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                ),
              ),
            const SizedBox(height: 24),
            Text(
              tt('Nama', 'Name'),
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              maxLength: 24,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _save(),
              decoration: InputDecoration(
                counterText: '',
                hintText: 'Listener',
                suffixIcon: IconButton(
                  icon: const Icon(FluentIcons.dismiss_24_regular, size: 20),
                  onPressed: _nameController.clear,
                ),
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton(
                onPressed: _save,
                child: Text(tt('Simpan Perubahan', 'Save Changes')),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton(
                onPressed: () => context.pop(),
                child: Text(tt('Batal', 'Cancel')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
