From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939
Date: Thu, 6 Oct 2016 14:26:10 +0200
Message-ID: <20161006122610.GG26915@airbook.vandijck-laurijssen.be>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <20161006084407.GB11907@airbook.vandijck-laurijssen.be>
 <a6920929-30e0-0c69-52f1-96998698bbf6@pengutronix.de>
 <20161006092403.GA26915@airbook.vandijck-laurijssen.be>
 <9472847f-aa01-f4b0-f2cc-968a04c6ce06@pengutronix.de>
 <20161006102643.GB26915@airbook.vandijck-laurijssen.be>
 <7a910650-0d91-e98c-8694-2d8b32ae68a7@pengutronix.de>
 <20161006111347.GC26915@airbook.vandijck-laurijssen.be>
 <20161006113244.GD26915@airbook.vandijck-laurijssen.be>
 <03b3bac9-b8c4-72ea-cc1d-9bf8f0210e3b@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:54207 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbcJFM1K (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2016 08:27:10 -0400
Content-Disposition: inline
In-Reply-To: <03b3bac9-b8c4-72ea-cc1d-9bf8f0210e3b@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

details :-)

commit 5f78bacf9df1df0c54f79f3008b5d74f9b020843
Author: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Date:   Thu Oct 6 14:20:16 2016

    can-j1939: update MAINTAINERS
    
    Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

diff --git a/MAINTAINERS b/MAINTAINERS
index 02ab672..32b59fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2819,9 +2819,8 @@ F:	include/uapi/linux/can/error.h
 F:	include/uapi/linux/can/netlink.h
 
 CAN-J1939 NETWORK LAYER
-M:	Kurt Van Dijck <kurt.van.dijck@eia.be>
-L:	socketcan-core@lists.berlios.de
-L:	netdev@vger.kernel.org
+M:	Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
+L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/j1939.txt
 F:	net/can/j1939/
