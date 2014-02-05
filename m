From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH iproute2] Add configuration for CAN FD drivers
Date: Wed, 05 Feb 2014 22:47:55 +0100
Message-ID: <52F2B18B.6070900@hartkopp.net>
References: <52F291E2.5000706@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:19365 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbaBEVr6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Feb 2014 16:47:58 -0500
In-Reply-To: <52F291E2.5000706@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>



On 05.02.2014 20:32, Oliver Hartkopp wrote:
> This patch add the userspace configuration for CAN FD drivers.
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> ---
> 
> diff --git a/include/linux/can/netlink.h b/include/linux/can/netlink.h
> index df944ed..7e2e186 100644
> --- a/include/linux/can/netlink.h
> +++ b/include/linux/can/netlink.h
> @@ -96,6 +96,7 @@ struct can_ctrlmode {
>  #define CAN_CTRLMODE_3_SAMPLES		0x04	/* Triple sampling mode */
>  #define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
>  #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
> +#define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
>  
>  /*
>   * CAN device statistics
> @@ -122,6 +123,8 @@ enum {
>  	IFLA_CAN_RESTART_MS,
>  	IFLA_CAN_RESTART,
>  	IFLA_CAN_BERR_COUNTER,
> +	IFLA_CAN_DATA_BITTIMING,
> +	IFLA_CAN_DATA_BITTIMING_CONST,
>  	__IFLA_CAN_MAX
>  };
>  
> diff --git a/ip/iplink_can.c b/ip/iplink_can.c
> index 5674358..ef3ede9 100644
> --- a/ip/iplink_can.c
> +++ b/ip/iplink_can.c
> @@ -27,11 +27,16 @@ static void usage(void)
>  	        "\t[ tq TQ prop-seg PROP_SEG phase-seg1 PHASE-SEG1\n "
>  		"\t  phase-seg2 PHASE-SEG2 [ sjw SJW ] ]\n"
>  		"\n"
> +	        "\t[ dbitrate BITRATE [ dsample-point SAMPLE-POINT] ] | \n"
> +	        "\t[ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1\n "
> +		"\t  dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]\n"
> +		"\n"
>  	        "\t[ loopback { on | off } ]\n"
>  	        "\t[ listen-only { on | off } ]\n"
>  	        "\t[ triple-sampling { on | off } ]\n"
>  	        "\t[ one-shot { on | off } ]\n"
>  	        "\t[ berr-reporting { on | off } ]\n"
> +	        "\t[ fd { on | off } ]\n"
>  		"\n"
>  	        "\t[ restart-ms TIME-MS ]\n"
>  	        "\t[ restart ]\n"
> @@ -88,6 +93,7 @@ static void print_ctrlmode(FILE *f, __u32 cm)
>  	_PF(CAN_CTRLMODE_3_SAMPLES, "TRIPLE-SAMPLING");
>  	_PF(CAN_CTRLMODE_ONE_SHOT, "ONE-SHOT");
>  	_PF(CAN_CTRLMODE_BERR_REPORTING, "BERR-REPORTING");
> +	_PF(CAN_CTRLMODE_FD, "FD");
>  #undef _PF
>  	if (cm)
>  		fprintf(f, "%x", cm);
> @@ -97,7 +103,7 @@ static void print_ctrlmode(FILE *f, __u32 cm)
>  static int can_parse_opt(struct link_util *lu, int argc, char **argv,
>  			 struct nlmsghdr *n)
>  {
> -	struct can_bittiming bt;
> +	struct can_bittiming bt, dbt;
>  	struct can_ctrlmode cm = {0, 0};
>  
>  	memset(&bt, 0, sizeof(bt));

memset(&dbt, 0, sizeof(dbt));

Was missing here ;-)

> @@ -134,6 +140,38 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
>  			NEXT_ARG();
>  			if (get_u32(&bt.sjw, *argv, 0))
>  				invarg("invalid \"sjw\" value\n", *argv);
> +		} else if (matches(*argv, "dbitrate") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&dbt.bitrate, *argv, 0))
> +				invarg("invalid \"dbitrate\" value\n", *argv);
> +		} else if (matches(*argv, "dsample-point") == 0) {
> +			float sp;
> +
> +			NEXT_ARG();
> +			if (get_float(&sp, *argv))
> +				invarg("invalid \"dsample-point\" value\n",
> +				       *argv);
> +			dbt.sample_point = (__u32)(sp * 1000);
> +		} else if (matches(*argv, "dtq") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&dbt.tq, *argv, 0))
> +				invarg("invalid \"dtq\" value\n", *argv);
> +		} else if (matches(*argv, "dprop-seg") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&dbt.prop_seg, *argv, 0))
> +				invarg("invalid \"dprop-seg\" value\n", *argv);
> +		} else if (matches(*argv, "dphase-seg1") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&dbt.phase_seg1, *argv, 0))
> +				invarg("invalid \"dphase-seg1\" value\n", *argv);
> +		} else if (matches(*argv, "dphase-seg2") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&dbt.phase_seg2, *argv, 0))
> +				invarg("invalid \"dphase-seg2\" value\n", *argv);
> +		} else if (matches(*argv, "dsjw") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&dbt.sjw, *argv, 0))
> +				invarg("invalid \"dsjw\" value\n", *argv);
>  		} else if (matches(*argv, "loopback") == 0) {
>  			NEXT_ARG();
>  			set_ctrlmode("loopback", *argv, &cm,
> @@ -154,6 +192,10 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
>  			NEXT_ARG();
>  			set_ctrlmode("berr-reporting", *argv, &cm,
>  				     CAN_CTRLMODE_BERR_REPORTING);
> +		} else if (matches(*argv, "fd") == 0) {
> +			NEXT_ARG();
> +			set_ctrlmode("fd", *argv, &cm,
> +				     CAN_CTRLMODE_FD);
>  		} else if (matches(*argv, "restart") == 0) {
>  			__u32 val = 1;
>  
> @@ -178,6 +220,8 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
>  
>  	if (bt.bitrate || bt.tq)
>  		addattr_l(n, 1024, IFLA_CAN_BITTIMING, &bt, sizeof(bt));
> +	if (dbt.bitrate || dbt.tq)
> +		addattr_l(n, 1024, IFLA_CAN_DATA_BITTIMING, &dbt, sizeof(dbt));
>  	if (cm.mask)
>  		addattr_l(n, 1024, IFLA_CAN_CTRLMODE, &cm, sizeof(cm));
>  
> @@ -249,6 +293,30 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  			btc->brp_min, btc->brp_max, btc->brp_inc);
>  	}
>  
> +	if (tb[IFLA_CAN_DATA_BITTIMING]) {
> +		struct can_bittiming *bt = RTA_DATA(tb[IFLA_CAN_DATA_BITTIMING]);
> +
> +		fprintf(f, "\n    "
> +			"dbitrate %d dsample-point %.3f ",
> +		        bt->bitrate, (float)bt->sample_point / 1000.);
> +		fprintf(f, "\n    "
> +			"dtq %d dprop-seg %d dphase-seg1 %d dphase-seg2 %d dsjw %d",
> +			bt->tq, bt->prop_seg, bt->phase_seg1, bt->phase_seg2,
> +			bt->sjw);
> +	}
> +
> +	if (tb[IFLA_CAN_DATA_BITTIMING_CONST]) {
> +		struct can_bittiming_const *btc =
> +			RTA_DATA(tb[IFLA_CAN_DATA_BITTIMING_CONST]);
> +
> +		fprintf(f, "\n    "
> +			"%s: dtseg1 %d..%d dtseg2 %d..%d "
> +			"dsjw 1..%d dbrp %d..%d dbrp-inc %d",
> +		        btc->name, btc->tseg1_min, btc->tseg1_max,
> +			btc->tseg2_min, btc->tseg2_max, btc->sjw_max,
> +			btc->brp_min, btc->brp_max, btc->brp_inc);
> +	}
> +
>  	if (tb[IFLA_CAN_CLOCK]) {
>  		struct can_clock *clock = RTA_DATA(tb[IFLA_CAN_CLOCK]);
>  
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
