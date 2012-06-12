From: yegorslists@googlemail.com
Subject: socketcan: license issues
Date: Tue, 12 Jun 2012 08:58:31 +0200
Message-ID: <1339484312-4281-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:36255 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733Ab2FLG6z (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 12 Jun 2012 02:58:55 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: wg@grandegger.com

During my effort bringing SocketCAN to Android I encountered following issue: Android devs found out that SocketCAN headers are not licensed as GPL2. See discussion here https://android-review.googlesource.com/#/c/34510/

I added GPL2 notion to the headers. Is it O.K. the way I made it or should we make this consistent for all SocketCAN files including the drivers?

Yegor

