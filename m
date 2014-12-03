From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: slcan/vcan: eliminate banner[] variable, switch
 to pr_info()
Date: Wed, 03 Dec 2014 11:10:41 +0100
Message-ID: <547EE1A1.9080203@hartkopp.net>
References: <1417596244-5743-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:45241 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbaLCKKw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Dec 2014 05:10:52 -0500
In-Reply-To: <1417596244-5743-1-git-send-email-jmmahler@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jeremiah Mahler <jmmahler@gmail.com>, linux-can@vger.kernel.org



On 03.12.2014 09:44, Jeremiah Mahler wrote:
> Several can modules in drivers/net/can use a banner[] variable at the
> top which defines a string that is used once during init.  This string
> is also embedded with KERN_INFO which makes it printk() specific.
>
> Improve the code by eliminating the banner[] variable and moving the
> string to where it is printed.  Then switch from printk(KERN_INFO to
> pr_info() for the lines that were changed.
>
> This patch is similar to [1] which was applied to net/can.
>
>    [1]: https://lkml.org/lkml/2014/11/22/10
>
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tnx

Oliver

> ---
>   drivers/net/can/slcan.c | 7 ++-----
>   drivers/net/can/vcan.c  | 5 +----
>   2 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
> index acb5b92..c837eb9 100644
> --- a/drivers/net/can/slcan.c
> +++ b/drivers/net/can/slcan.c
> @@ -56,9 +56,6 @@
>   #include <linux/can.h>
>   #include <linux/can/skb.h>
>
> -static __initconst const char banner[] =
> -	KERN_INFO "slcan: serial line CAN interface driver\n";
> -
>   MODULE_ALIAS_LDISC(N_SLCAN);
>   MODULE_DESCRIPTION("serial line CAN interface");
>   MODULE_LICENSE("GPL");
> @@ -702,8 +699,8 @@ static int __init slcan_init(void)
>   	if (maxdev < 4)
>   		maxdev = 4; /* Sanity */
>
> -	printk(banner);
> -	printk(KERN_INFO "slcan: %d dynamic interface channels.\n", maxdev);
> +	pr_info("slcan: serial line CAN interface driver\n");
> +	pr_info("slcan: %d dynamic interface channels.\n", maxdev);
>
>   	slcan_devs = kzalloc(sizeof(struct net_device *)*maxdev, GFP_KERNEL);
>   	if (!slcan_devs)
> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
> index 4e94057..674f367 100644
> --- a/drivers/net/can/vcan.c
> +++ b/drivers/net/can/vcan.c
> @@ -50,9 +50,6 @@
>   #include <linux/slab.h>
>   #include <net/rtnetlink.h>
>
> -static __initconst const char banner[] =
> -	KERN_INFO "vcan: Virtual CAN interface driver\n";
> -
>   MODULE_DESCRIPTION("virtual CAN interface");
>   MODULE_LICENSE("Dual BSD/GPL");
>   MODULE_AUTHOR("Urs Thuermann <urs.thuermann@volkswagen.de>");
> @@ -173,7 +170,7 @@ static struct rtnl_link_ops vcan_link_ops __read_mostly = {
>
>   static __init int vcan_init_module(void)
>   {
> -	printk(banner);
> +	pr_info("vcan: Virtual CAN interface driver\n");
>
>   	if (echo)
>   		printk(KERN_INFO "vcan: enabled echo on driver level.\n");
>
