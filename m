From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] usb2can: Add support for USB2CAN interface from 8 devices
Date: Mon, 03 Dec 2012 21:12:02 +0100
Message-ID: <50BD0792.4010207@grandegger.com>
References: <50BB1E8E.10809@universalnet.at> <50BB592B.4030604@grandegger.com> <50BBF5CA.500@universalnet.at> <50BC540C.4040800@grandegger.com> <50BCF810.6060108@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:39464 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab2LCUM0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Dec 2012 15:12:26 -0500
In-Reply-To: <50BCF810.6060108@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "krumboeck@universalnet.at" <krumboeck@universalnet.at>
Cc: Linux-CAN <linux-can@vger.kernel.org>

On 12/03/2012 08:05 PM, krumboeck@universalnet.at wrote:
> Hi Wolfgang!
> 
> 
>>> The Script checkpatch.pl didn't like this comment style. I'll change it
>>> again.
>>
>> I'm confused. Could you please show the comment and the checkpatch.pl
>> message. I hope it does not argue against:
>>
>> http://lxr.linux.no/#linux+v3.6.8/Documentation/CodingStyle#L446
> 
> ...
> /*
>  * Send command to device and receive result.
>  * Command was successful when opt1 = 0.
>  */
> static int usb_8dev_send_cmd(struct usb_8dev *dev, struct
> usb_8dev_cmd_msg *out,
>                             struct usb_8dev_cmd_msg *in)
> {
> ...
> 
> WARNING: networking block comments don't use an empty /* line, use /*
> Comment...
> #248: FILE: drivers/net/can/usb/usb_8dev.c:204:
> +
> +/*
> 
> ...
> /*
>  * Set network device mode
>  *
>  * Maybe we should leave this function empty, because the device
>  * set mode variable with open command.
>  */
> static int usb_8dev_set_mode(struct net_device *netdev, enum can_mode mode)
> {
>         struct usb_8dev *dev = netdev_priv(netdev);
> ...
> 
> WARNING: networking block comments don't use an empty /* line, use /*
> Comment...
> #413: FILE: drivers/net/can/usb/usb_8dev.c:369:
> +
> +/*
> 

Wow, I obviously missed the following commit:

commit c4ff1b5f8bf09d77d7329cbff224f0237646c90e
Author: Joe Perches <joe@perches.com>
Date:   Thu Oct 4 17:13:36 2012 -0700

    CodingStyle: add networking specific block comment style
    
    The block comment style in net/ and drivers/net is non-standard.
    Document it.
    
    Signed-off-by: Joe Perches <joe@perches.com>
    Cc: "Allan, Bruce W" <bruce.w.allan@intel.com>
    Cc: Andy Whitcroft <apw@canonical.com>
    Cc: David Miller <davem@davemloft.net>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
index cb9258b..495e5ba 100644
index cb9258b..495e5ba 100644
--- a/Documentation/CodingStyle
+++ b/Documentation/CodingStyle
@@ -454,6 +454,16 @@ The preferred style for long (multi-line) comments is:
         * with beginning and ending almost-blank lines.
         */
 
+For files in net/ and drivers/net/ the preferred style for long (multi-line)
+comments is a little different.
+
+       /* The preferred comment style for files in net/ and drivers/net
+        * looks like this.
+        *
+        * It is nearly the same as the generally preferred comment style,
+        * but there is no initial almost-blank line.
+        */
+
 It's also important to comment data, whether they are basic types or derived
 types.  To this end, use just one data declaration per line (no commas for
 multiple data declarations).  This leaves you room for a small comment on each


Well, no comment. Sorry for the noise then. Feel free to choose what
you like (from my point of view). A *common* style seems not really to be
important.

Wolfgang.

