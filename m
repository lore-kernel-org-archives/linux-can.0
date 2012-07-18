From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH 1/6] can: janz-ican3: remove dead code
Date: Wed, 18 Jul 2012 15:33:13 -0700
Message-ID: <1342650798-2991-2-git-send-email-iws@ovro.caltech.edu>
References: <1342650798-2991-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:50085 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab2GRWdU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 18:33:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by ovro.ovro.caltech.edu (Postfix) with ESMTP id E1E7322298
	for <linux-can@vger.kernel.org>; Wed, 18 Jul 2012 15:33:19 -0700 (PDT)
In-Reply-To: <1342650798-2991-1-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

The code which used this variable was removed during review, before the
driver was added to mainline Linux. It is now dead code, and can be
removed.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/net/can/janz-ican3.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 08c893c..020055e 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -235,7 +235,6 @@ struct ican3_dev {
 
 	/* fast host interface */
 	unsigned int fastrx_start;
-	unsigned int fastrx_int;
 	unsigned int fastrx_num;
 	unsigned int fasttx_start;
 	unsigned int fasttx_num;
@@ -454,7 +453,6 @@ static void __devinit ican3_init_fast_host_interface(struct ican3_dev *mod)
 	/* save the start recv page */
 	mod->fastrx_start = mod->free_page;
 	mod->fastrx_num = 0;
-	mod->fastrx_int = 0;
 
 	/* build a single fast tohost queue descriptor */
 	memset(&desc, 0, sizeof(desc));
-- 
1.7.8.6

