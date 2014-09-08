From: Andri Yngvason <Andri.Yngvason@marel.com>
Subject: Inconsistent error state transition error frames
Date: Mon, 8 Sep 2014 16:26:55 +0000
Message-ID: <7EAA3DE6DC6BA14D830C95541CC66EBC9F72FED6@GRBSR0004.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2lp0212.outbound.protection.outlook.com ([207.46.163.212]:5842
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753550AbaIHQ06 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Sep 2014 12:26:58 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,

I've been working on a userspace program to monitor the CAN bus and I found that it only works as expected on one platform (flexcan). The problem is that on most other platforms, no error frame is emitted when the controller transitions back to error-active state. I see that you've already discussed this on this list here: http://thread.gmane.org/gmane.linux.can/201 

Why hasn't this been resolved?

I already patched the mscan and sja1000 drivers myself, and I was considering submitting them, but since you've already done some work on this (which I believe is superior to mine), my work is unlikely to be of any consequence to this community, except to show that this inconsistency does indeed result in wasted effort and frustration.

Of course, I'll help out if I can, e.g. by testing on the platforms that I have available.

Best regards,
Andri Yngvason