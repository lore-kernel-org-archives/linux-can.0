From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 02/14] can: give structs holding the CAN statistics a
 sensible name
Date: Fri, 25 Aug 2017 19:32:28 +0200
Message-ID: <e3913ee0-93cc-2b22-dec2-75321a9b1ac7@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-3-mkl@pengutronix.de>
 <92a0dacc-e1d2-435e-2bee-0ff0a20a655e@hartkopp.net>
 <361c5e96-0e89-ba24-4fbf-18087470bc69@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:19133 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755564AbdHYRcd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Aug 2017 13:32:33 -0400
In-Reply-To: <361c5e96-0e89-ba24-4fbf-18087470bc69@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de



On 08/25/2017 03:08 PM, Marc Kleine-Budde wrote:
> On 08/24/2017 02:58 PM, Oliver Hartkopp wrote:
>> Naming structs and its instances identically is bad.
>>
>> On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
>>
>>>    struct netns_can {
>>>    #if IS_ENABLED(CONFIG_PROC_FS)
>>> @@ -30,8 +30,8 @@ struct netns_can {
>>>    	struct dev_rcv_lists *can_rx_alldev_list;
>>>    	spinlock_t can_rcvlists_lock;
>>>    	struct timer_list can_stattimer;/* timer for statistics update */
>>> -	struct s_stats *can_stats;	/* packet statistics */
>>> -	struct s_pstats *can_pstats;	/* receive list statistics */
>>> +	struct can_stats *can_stats; /* packet statistics */
>>> +	struct can_pstats *can_pstats; /* receive list statistics */
>                                 ^
> Now I found out what that "p" originally means:
> 
>> /* persistent statistics */
>> struct can_pstats {
>> 	unsigned long stats_reset;
>> 	unsigned long user_reset;
>> 	unsigned long rcv_entries;
>> 	unsigned long rcv_entries_max;
>> };
> 
> \o/
> 
>> If you really want to rename this stuff, what about this:
>>
>> struct can_pkt_stats *can_stats; /* packet statistics */
>> struct can_rxl_stats *can_rstats; /* receive list statistics */
>               ^^^
> We're using rcv_list(s) instead of rxl in various other places.
> 
> If we give the variables speaking names, the comments are obsolete:
> 
> struct can_pkg_stats *can_pkg_stats;
> struct can_rcv_list_stats *can_rcv_list_stats;
> 
> We can remove the "can_" prefix of the variables in the struct
> netns_can, as the struct already has the "can" in it.

Yes. Good idea.

> 
> So the struct becomes:
> 
>> struct netns_can {
>> #if IS_ENABLED(CONFIG_PROC_FS)
>> 	struct proc_dir_entry *proc_dir;
>> 	struct proc_dir_entry *pde_version;
>> 	struct proc_dir_entry *pde_stats;
>> 	struct proc_dir_entry *pde_reset_stats;
>> 	struct proc_dir_entry *pde_rcvlist_all;
>> 	struct proc_dir_entry *pde_rcvlist_fil;
>> 	struct proc_dir_entry *pde_rcvlist_inv;
>> 	struct proc_dir_entry *pde_rcvlist_sff;
>> 	struct proc_dir_entry *pde_rcvlist_eff;
>> 	struct proc_dir_entry *pde_rcvlist_err;
>> 	struct proc_dir_entry *bcmproc_dir;
>> #endif
>>
>> 	/* receive filters subscribed for 'all' CAN devices */
>> 	struct can_dev_rcv_lists *rx_alldev_list;
>> 	spinlock_t rcvlists_lock;
>> 	struct timer_list stattimer; /* timer for statistics update */
>> 	struct can_pkg_stats *pkg_stats;
>> 	struct can_rcv_lists_stats *rcv_lists_stats;

Agreed :-)

So it would look like this then:

diff --git a/net/can/proc.c b/net/can/proc.c
index 83045f00c63c..559fca8035aa 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -77,14 +77,14 @@ static const char rx_list_name[][8] = {

  static void can_init_stats(struct net *net)
  {
-	struct s_stats *can_stats = net->can.can_stats;
-	struct s_pstats *can_pstats = net->can.can_pstats;
+	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
+	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;

Right?

Best regards,
Oliver

>>
>> #if IS_ENABLED(CONFIG_CAN_GW)
>> 	/* CAN GW per-net gateway jobs */
>> 	struct hlist_head cgw_list;
>> #endif
>> };
> 
> regards,
> Marc
> 
