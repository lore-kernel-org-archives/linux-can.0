From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [RFC] WIP-patches on sllin
Date: Tue, 10 Dec 2013 18:16:11 +0100
Message-ID: <1386695777-18463-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:55784 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752816Ab3LJRXT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Dec 2013 12:23:19 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?q?Rostislav=20Lisov=C3=BD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org

Hello,

I'm currently working with sllin (LIN based on socketcan) from
git://rtime.felk.cvut.cz/linux-lin.git / https://rtime.felk.cvut.cz/gitweb/linux-lin.git/shortlog.
Up to now master is working pretty well and I fixed a bug for slave node
(patch 5). I'm currently working on LIN slave task on slave node which was
unimplemented up to now.
This first version uses the slave cache for message sending when requested,
but so it is no longer possible to configure the length for specific message
IDs which are only recweived. The LIN_CACHE_RESPONSE bit is used up to now
to configure the data length (DLC) of receptions in slave mode. This doesn't
work anymore when slave responses to configured IDs.
Are there any comments to distinguish between configured for sending and
configured for reception only? I tried to avoid addig a new bit for that, but
didn't find any idea for that.
I still would acknowledge comments on the other patches.

Best regards,
Alexander

