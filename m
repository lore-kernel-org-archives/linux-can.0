From: Amit Virdi <amit.virdi@st.com>
Subject: [PATCH 0/3] c_can: Update can support
Date: Thu, 20 Dec 2012 15:35:41 +0530
Message-ID: <cover.1355996839.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:33821 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751423Ab2LTKGI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Dec 2012 05:06:08 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, bhupesh.sharma@st.com, anilkumar@ti.com, spear-devel@list.st.com, Amit Virdi <amit.virdi@st.com>

This patchset aims to improve the Bosch c_can driver support. The changes are
as a result of problems encountered using the c_can driver on SPEAr platform.

Although significant care has been taken to ensure that the changes don't break
the existing functionality, however there might be some hiccups on other platforms.

The patch to provide generic interface is provided to add more flexibility for
the end applications.

The patches have been tested on SPEAr1310 EVB and the patchset rebased on master
of http://git.gitorious.org/linux-can/linux-can-next.git

Amit Virdi (3):
  can: c_can: Correct register alignment info passing through DT
  can: c_can: Provide generic interface to configure c-can message
    objects
  can: c_can: Enable clock before first use

 .../devicetree/bindings/net/can/c_can.txt          |  59 ++++++++++--
 drivers/net/can/c_can/c_can.c                      | 100 ++++++++++++---------
 drivers/net/can/c_can/c_can.h                      |  16 +++-
 drivers/net/can/c_can/c_can_platform.c             |  66 +++++++++++++-
 4 files changed, 190 insertions(+), 51 deletions(-)

-- 
1.8.0

