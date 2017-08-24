From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 05/14] can: proc: give variable holding the CAN per device
 receive lists a sensible name
Date: Thu, 24 Aug 2017 15:05:11 +0200
Message-ID: <0cde3b8e-19ee-fdfb-cd2f-6f4cf51d2c84@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-6-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:35400 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbdHXNFM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2017 09:05:12 -0400
In-Reply-To: <20170802174434.4689-6-mkl@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de



On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
> This patch gives the variables holding the CAN per device receive filter lists
> a better name by renaming them from "d" to "dev_rcv_lists".

Same comment as in patch 04/14:

'd' might be too short and not be easy to bring into connection with 
can_dev_rcv_lists ... but 'dev_rcv_lists' smells like just another 
structure definition an not a handy variable name, like e.g. cdrl

Regards,
Oliver

> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   net/can/proc.c | 38 ++++++++++++++++++++------------------
>   1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/net/can/proc.c b/net/can/proc.c
> index b06ea3823b07..966dd53f8fa4 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -338,11 +338,11 @@ static const struct file_operations can_version_proc_fops = {
>   
>   static inline void can_rcvlist_proc_show_one(struct seq_file *m, int idx,
>   					     struct net_device *dev,
> -					     struct can_dev_rcv_lists *d)
> +					     struct can_dev_rcv_lists *dev_rcv_lists)
>   {
> -	if (!hlist_empty(&d->rx[idx])) {
> +	if (!hlist_empty(&dev_rcv_lists->rx[idx])) {
>   		can_print_recv_banner(m);
> -		can_print_rcvlist(m, &d->rx[idx], dev);
> +		can_print_rcvlist(m, &dev_rcv_lists->rx[idx], dev);
>   	} else
>   		seq_printf(m, "  (%s: no entry)\n", DNAME(dev));
>   
> @@ -353,7 +353,7 @@ static int can_rcvlist_proc_show(struct seq_file *m, void *v)
>   	/* double cast to prevent GCC warning */
>   	int idx = (int)(long)PDE_DATA(m->file->f_inode);
>   	struct net_device *dev;
> -	struct can_dev_rcv_lists *d;
> +	struct can_dev_rcv_lists *dev_rcv_lists;
>   	struct net *net = m->private;
>   
>   	seq_printf(m, "\nreceive list '%s':\n", rx_list_name[idx]);
> @@ -361,8 +361,8 @@ static int can_rcvlist_proc_show(struct seq_file *m, void *v)
>   	rcu_read_lock();
>   
>   	/* receive list for 'all' CAN devices (dev == NULL) */
> -	d = net->can.can_rx_alldev_list;
> -	can_rcvlist_proc_show_one(m, idx, NULL, d);
> +	dev_rcv_lists = net->can.can_rx_alldev_list;
> +	can_rcvlist_proc_show_one(m, idx, NULL, dev_rcv_lists);
>   
>   	/* receive list for registered CAN devices */
>   	for_each_netdev_rcu(net, dev) {
> @@ -417,7 +417,7 @@ static inline void can_rcvlist_proc_show_array(struct seq_file *m,
>   static int can_rcvlist_sff_proc_show(struct seq_file *m, void *v)
>   {
>   	struct net_device *dev;
> -	struct can_dev_rcv_lists *d;
> +	struct can_dev_rcv_lists *dev_rcv_lists;
>   	struct net *net = m->private;
>   
>   	/* RX_SFF */
> @@ -426,15 +426,16 @@ static int can_rcvlist_sff_proc_show(struct seq_file *m, void *v)
>   	rcu_read_lock();
>   
>   	/* sff receive list for 'all' CAN devices (dev == NULL) */
> -	d = net->can.can_rx_alldev_list;
> -	can_rcvlist_proc_show_array(m, NULL, d->rx_sff, ARRAY_SIZE(d->rx_sff));
> +	dev_rcv_lists = net->can.can_rx_alldev_list;
> +	can_rcvlist_proc_show_array(m, NULL, dev_rcv_lists->rx_sff,
> +				    ARRAY_SIZE(dev_rcv_lists->rx_sff));
>   
>   	/* sff receive list for registered CAN devices */
>   	for_each_netdev_rcu(net, dev) {
>   		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
> -			d = dev->ml_priv;
> -			can_rcvlist_proc_show_array(m, dev, d->rx_sff,
> -						    ARRAY_SIZE(d->rx_sff));
> +			dev_rcv_lists = dev->ml_priv;
> +			can_rcvlist_proc_show_array(m, dev, dev_rcv_lists->rx_sff,
> +						    ARRAY_SIZE(dev_rcv_lists->rx_sff));
>   		}
>   	}
>   
> @@ -461,7 +462,7 @@ static const struct file_operations can_rcvlist_sff_proc_fops = {
>   static int can_rcvlist_eff_proc_show(struct seq_file *m, void *v)
>   {
>   	struct net_device *dev;
> -	struct can_dev_rcv_lists *d;
> +	struct can_dev_rcv_lists *dev_rcv_lists;
>   	struct net *net = m->private;
>   
>   	/* RX_EFF */
> @@ -470,15 +471,16 @@ static int can_rcvlist_eff_proc_show(struct seq_file *m, void *v)
>   	rcu_read_lock();
>   
>   	/* eff receive list for 'all' CAN devices (dev == NULL) */
> -	d = net->can.can_rx_alldev_list;
> -	can_rcvlist_proc_show_array(m, NULL, d->rx_eff, ARRAY_SIZE(d->rx_eff));
> +	dev_rcv_lists = net->can.can_rx_alldev_list;
> +	can_rcvlist_proc_show_array(m, NULL, dev_rcv_lists->rx_eff,
> +				    ARRAY_SIZE(dev_rcv_lists->rx_eff));
>   
>   	/* eff receive list for registered CAN devices */
>   	for_each_netdev_rcu(net, dev) {
>   		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
> -			d = dev->ml_priv;
> -			can_rcvlist_proc_show_array(m, dev, d->rx_eff,
> -						    ARRAY_SIZE(d->rx_eff));
> +			dev_rcv_lists = dev->ml_priv;
> +			can_rcvlist_proc_show_array(m, dev, dev_rcv_lists->rx_eff,
> +						    ARRAY_SIZE(dev_rcv_lists->rx_eff));
>   		}
>   	}
>   
> 
