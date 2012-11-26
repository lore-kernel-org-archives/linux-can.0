From: Ulrich Escher <ulrich.escher@myvdr.de>
Subject: [PATCH] slcanpty.c Remove one Bug
Date: Mon, 26 Nov 2012 01:12:23 +0100
Message-ID: <50B2B3E7.5040202@myvdr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay06.ispgateway.de ([80.67.31.103]:48713 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706Ab2KZARi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 25 Nov 2012 19:17:38 -0500
Received: from [176.34.235.140] (helo=[0.0.0.0])
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ulrich.escher@myvdr.de>)
	id 1TcmJE-0000hd-Sl
	for linux-can@vger.kernel.org; Mon, 26 Nov 2012 01:12:25 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

It is an error to overwrite nbytes at this point.
LG Ulrich

Signed-off-by: ulrich escher<git@myvdr.de>
---
  slcanpty.c |    4 +++-----
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/slcanpty.c b/slcanpty.c
index e3b7304..3c1935a 100644
--- a/slcanpty.c
+++ b/slcanpty.c
@@ -281,8 +279,8 @@ rx_restart:
                         ptr--;
         }

-       nbytes = write(socket, &frame, sizeof(frame));
-       if (nbytes != sizeof(frame)) {
+       tmp = write(socket, &frame, sizeof(frame));
+       if (tmp != sizeof(frame)) {
                 perror("write socket");
                 return 1;
         }


