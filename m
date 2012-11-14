From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [INFO] can-utils now with CAN FD support in master branch
Date: Wed, 14 Nov 2012 21:07:02 +0100
Message-ID: <50A3F9E6.1080300@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:19669 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161081Ab2KNUHF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Nov 2012 15:07:05 -0500
Received: from [192.168.178.23] (p5B0B07AD.dip0.t-ipconnect.de [91.11.7.173])
	by smtp.strato.de (jored mo17) (RZmta 31.3 DYNA|AUTH)
	with ESMTPA id w024efoAEJ7Fjn for <linux-can@vger.kernel.org>;
	Wed, 14 Nov 2012 21:07:03 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi all,

after several tests it is time to make the CAN FD support available in the
'mainline' can-utils.

I splitted the former patches in the canfd branch into the CAN FD related
changes and functional enhancements (formatting of EFF/SFF output and the
display of additional CAN frame flags).

Based on these changes i added a patch provided by Andre Naujoks for the cangw
tool, removed some compiler warnings and also removed the obsolete SVN Id tags.

Please let me know if you discover any problems - which i do not expect of
course ;-)

Have fun!

Oliver
