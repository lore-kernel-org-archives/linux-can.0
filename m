From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: can-next pull request for CAN ID Ematch
Date: Wed, 04 Jul 2012 08:03:43 +0200
Message-ID: <4FF3DCBF.2040905@hartkopp.net>
References: <4FF3C278.8040200@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:9367 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab2GDGHJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Jul 2012 02:07:09 -0400
In-Reply-To: <4FF3C278.8040200@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Rostislav Lisovy <lisovy@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, =?windows-1252?Q?Pavel_P=ED=9Aa?= <pisa@cmp.felk.cvut.cz>, Michal Sojka <sojkam1@fel.cvut.cz>

Hi all,

the pull location is still valid :-)

Btw. i needed to change a minor thing as the em_canid_match() function did
not handle the case that the same CAN-ID can be SFF or EFF ...

The option to support the CAN_EFF_FLAG cleared in the can_mask is broken,
unusual and can not be handled in a simple way.

The tc tool can handle eff and sff rules - and so i did it in the
em_canid_change() function now. No support for CAN_EFF_FLAG cleared in the
can_mask - just check the CAN_EFF_FLAG in the filter.can_id to decide the
rules type.

See at line 146ff here:

https://gitorious.org/~hartkopp/linux-can/ollis-can-next/commit/e8edbabb5955e1444f69136eae2f52889a42b153

Additional i kicked out the pointless "else { continue; }" statements 8-)

Regards,
Oliver

On 04.07.2012 06:11, Oliver Hartkopp wrote:

> Hello Marc, hello Rostislav,
> 
> as Rostislav seems to be absent, i fixed the minor issues myself and created
> a branch for that in my ollis-can-next git repo.
> 
> FYI the changes can be seen in the patch at the end of this mail.
> 
> 
> The following changes since commit 0e1aa9cfe6db4689f98b20afe808b4f9cdb0b6c0:
> 
>   em_canid: Ematch rule to match CAN frames according to their identifiers (2012-07-04 05:32:03 +0200)
> 
> are available in the git repository at:
> 
>   git://gitorious.org/~hartkopp/linux-can/ollis-can-next.git em_can
> 
> for you to fetch changes up to 0e1aa9cfe6db4689f98b20afe808b4f9cdb0b6c0:
> 
>   em_canid: Ematch rule to match CAN frames according to their identifiers (2012-07-04 05:32:03 +0200)
> 
> 
> diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
> index d607e78..dc9f515 100644
> --- a/net/sched/em_canid.c
> +++ b/net/sched/em_canid.c
> @@ -123,13 +123,10 @@ static int em_canid_match(struct sk_buff *skb, struct tcf_ematch *m,
>  static int em_canid_change(struct tcf_proto *tp, void *data, int len,
>  			  struct tcf_ematch *m)
>  {
> -	struct can_filter *conf = data; /* Array with rules,
> -					 * fixed size EM_CAN_RULES_SIZE
> -					 */
> +	struct can_filter *conf = data; /* Array with rules */
>  	struct canid_match *cm;
>  	struct canid_match *cm_old = (struct canid_match *)m->data;
>  	int i;
> -	int rulescnt;
>  
>  	if (!len)
>  		return -EINVAL;
> @@ -140,43 +137,37 @@ static int em_canid_change(struct tcf_proto *tp, void *data, int len,
>  	if (len > sizeof(struct can_filter) * EM_CAN_RULES_MAX)
>  		return -EINVAL;
>  
> -	rulescnt = len / sizeof(struct can_filter);
> -
> -	cm = kzalloc(sizeof(struct canid_match) + sizeof(struct can_filter) *
> -		rulescnt, GFP_KERNEL);
> +	cm = kzalloc(sizeof(struct canid_match) + len, GFP_KERNEL);
>  	if (!cm)
>  		return -ENOMEM;
>  
> -	cm->sff_rules_count = 0;
> -	cm->eff_rules_count = 0;
> -	cm->rules_count = rulescnt;
> +	cm->rules_count = len / sizeof(struct can_filter);
>  
>  	/*
>  	 * We need two for() loops for copying rules into
>  	 * two contiguous areas in rules_raw
>  	 */
>  
> -	/* Process EFF frame rules*/
> +	/* Process EFF and mixed EFF/SFF frame rules*/
>  	for (i = 0; i < cm->rules_count; i++) {
> -		if (((conf[i].can_id & CAN_EFF_FLAG) &&
> -		    (conf[i].can_mask & CAN_EFF_FLAG)) ||
> -		    !(conf[i].can_mask & CAN_EFF_FLAG)) {
> +		if (!(conf[i].can_id & CAN_EFF_FLAG) &&
> +		    (conf[i].can_mask & CAN_EFF_FLAG)) {
> +			/* SFF only filter */
> +			continue;
> +		} else {
>  			memcpy(cm->rules_raw + cm->eff_rules_count,
>  				&conf[i],
>  				sizeof(struct can_filter));
>  
>  			cm->eff_rules_count++;
> -		} else {
> -			continue;
>  		}
>  	}
>  
>  	/* Process SFF frame rules */
>  	for (i = 0; i < cm->rules_count; i++) {
> -		if ((conf[i].can_id & CAN_EFF_FLAG) &&
> +		if (!(conf[i].can_id & CAN_EFF_FLAG) &&
>  		    (conf[i].can_mask & CAN_EFF_FLAG)) {
> -			continue;
> -		} else {
> +			/* SFF only filter */
>  			memcpy(cm->rules_raw
>  				+ cm->eff_rules_count
>  				+ cm->sff_rules_count,
> @@ -186,10 +177,12 @@ static int em_canid_change(struct tcf_proto *tp, void *data, int len,
>  
>  			em_canid_sff_match_add(cm,
>  				conf[i].can_id, conf[i].can_mask);
> +		} else {
> +			continue;
>  		}
>  	}
>  
> -	m->datalen = sizeof(*cm);
> +	m->datalen = sizeof(struct canid_match) + len;
>  	m->data = (unsigned long)cm;
>  
>  	if (cm_old != NULL) {
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


