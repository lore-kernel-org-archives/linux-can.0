From: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
Subject: [RFC PATCH] CAN MAINTAINERS
Date: Fri, 02 Dec 2011 09:46:08 +0100
Message-ID: <4ED89050.3040201@hartkopp.net>
References: <48E9EDF6.4000009@pengutronix.de>	<4ED6B460.2010508@pengutronix.de>	<4ED7351E.2010907@grandegger.com>	<4ED745F6.8030302@pengutronix.de>
	<4ED7494F.6080603@grandegger.com>	<4ED74AC7.40605@pengutronix.de>
	<4ED75BD0.6070802@hartkopp.net> <4ED75EED.6010009@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <4ED75EED.6010009-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-core>
List-Post: <mailto:socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, Urs Thuermann <urs-5sm3ckEb1NlYFmeL5InDC7NAH6kLmebB@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

On 01.12.2011 12:03, Marc Kleine-Budde wrote:

> On 12/01/2011 11:49 AM, Oliver Hartkopp wrote:


>> As the net tree only get's fixes i wonder why we should clone that tree?
>> Working directly on Dave's net-tree for fixes looks straight forward to me.
> 
> Thinking about it - yes, what about just keeping linux-can-next.
> 
>> But the idea for a linux-can-next is great.
>>
>> This would settle the process that we discuss new drivers & changes on
>> linux-can ML and finally commit the stuff in linux-can-next, where one of us
>> can send a pull request to Dave.
> 
> ...you send the pull request.
> 
>> So everything beyond fixes would go this way then.
> 
> +1
> 
> So we communicate to davem that we now have a git tree, and Oliver is
> the one that send the pull requests. Let's ask him if he wants to see
> the patches in the pull request.


Hey Marc,

i'm not as good as you using git. Indeed i'm a git newbie and do not have the
time right now to get in that deep that i dare to post correct pull requests
to netdev.

Following the hints from Dave i checked the MAINTAINERS file how the wireless
guys handle their subsystem in detail. Regarding John Linville, who's
collecting all the stuff from several people to send finally push requests to
Dave i would suggest that you become our 'John Linville for CAN'.

You speak git fluently and you know the project very good - so my suggestion
to clean up the MAINTAINTERS file is this:


diff --git a/MAINTAINERS b/MAINTAINERS
index 717d9e9..af8a0a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1707,11 +1707,8 @@ F:	arch/x86/include/asm/tce.h

 CAN NETWORK LAYER
 M:	Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
-M:	Oliver Hartkopp <oliver.hartkopp-l29pVbxQd1IUtdQbppsyvg@public.gmane.org>
-M:	Urs Thuermann <urs.thuermann-l29pVbxQd1IUtdQbppsyvg@public.gmane.org>
 L:	linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
-L:	netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
-W:	http://developer.berlios.de/projects/socketcan/
+W:	http://gitorious.org/linux-can
 S:	Maintained
 F:	net/can/
 F:	include/linux/can.h
@@ -1723,8 +1720,7 @@ F:	include/linux/can/gw.h
 CAN NETWORK DRIVERS
 M:	Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
 L:	linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
-L:	netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
-W:	http://developer.berlios.de/projects/socketcan/
+W:	http://gitorious.org/linux-can
 S:	Maintained
 F:	drivers/net/can/
 F:	include/linux/can/dev.h
@@ -4587,6 +4583,17 @@ F:	include/linux/wireless.h
 F:	include/net/iw_handler.h
 F:	drivers/net/wireless/

+NETWORKING [CAN]
+M:	Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
+L:	linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+W:	http://gitorious.org/linux-can
+T:	git://gitorious.org/linux-can/linux-can.git
+T:	git://gitorious.org/linux-can/linux-can-next.git
+S:	Maintained
+F:	net/can/
+F:	drivers/net/can/
+F:	include/linux/can*
+
 NETWORKING DRIVERS
 L:	netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 W:	http://www.linuxfoundation.org/en/Net



Regards,
Oliver
