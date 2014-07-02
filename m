From: Andre Naujoks <nautsch2@gmail.com>
Subject: [PATCH] do not use --symlink for autoreconf
Date: Wed,  2 Jul 2014 14:12:58 +0200
Message-ID: <1404303178-24608-1-git-send-email-nautsch2@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:63771 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbaGBMNH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Jul 2014 08:13:07 -0400
Received: by mail-wi0-f169.google.com with SMTP id hi2so8891682wib.2
        for <linux-can@vger.kernel.org>; Wed, 02 Jul 2014 05:13:05 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, Andre Naujoks <nautsch2@gmail.com>

When packaging the can-utils, I understand, that the generation step for
autoconf should be done beforehand. However using the --symlink option in the
autoreconf step installs links instead of the actual files, which leads to a
build failure when trying to build on another host with different autotools
installed.

Signed-off-by: Andre Naujoks <nautsch2@gmail.com>
---
 autogen.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autogen.sh b/autogen.sh
index 29db9c9..6d1c20a 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -17,6 +17,6 @@ banner() {
 
 banner "autoreconf"
 
-autoreconf --force --install --symlink -Wall || exit $?
+autoreconf --force --install -Wall || exit $?
 
 banner "Finished"
-- 
2.0.1

