From: ajneu <ajneu1@gmail.com>
Subject: programatically determine netlink-type: can or vcan ...
Date: Tue, 21 Jun 2016 14:40:24 +0000 (UTC)
Message-ID: <loom.20160621T163010-819@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43958 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbcFUO5t (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 21 Jun 2016 10:57:49 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bFMqx-0006gG-HK
	for linux-can@vger.kernel.org; Tue, 21 Jun 2016 16:40:35 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 21 Jun 2016 16:40:35 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 21 Jun 2016 16:40:35 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

how can one determine the netlink-type (can or vcan, ...) of an
interface-name (e.g. can1), from a C program?

It would be great if I can e.g. get that from /sys/class/net/can1 somehow.

What would work, but is NOT nice (because of portability problems), is to
use the C-function system:

if (system("test \"$(ip link show can1 type vcan)\" !=  \"\"")) {
   printf("can1 is not vcan\n");
} else {
   printf("can1 is vcan\n");
}

Thanks.
ajneu



