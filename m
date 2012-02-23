From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 1/3 v6] can/usb: PEAK-System Technik USB adapters driver
 core
Date: Thu, 23 Feb 2012 12:08:40 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1202231205420.1671-100000@iolanthe.rowland.org>
References: <1329985867-11082-2-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329985867-11082-2-git-send-email-s.grosjean-g4cQ8AsIbFbL9ATBNaCtXw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephane Grosjean <s.grosjean-g4cQ8AsIbFbL9ATBNaCtXw@public.gmane.org>
Cc: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>, linux-can Mailing List <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux usb Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

On Thu, 23 Feb 2012, Stephane Grosjean wrote:

> This patch adds the core of the peak_usb driver which handles PEAK-System
> Technik PCAN USB adapters. It defines the parts which are common to the
> PCAN-USB adapters: can network interfaces management, network-to/from-usb
> data path interface, timestamps management...

...

> +/*
> + * dump memory
> + */
> +#define DUMP_WIDTH	16
> +void dump_mem(char *prompt, void *p, int l)
> +{
> +	char tmp[(3 * DUMP_WIDTH) + 1];
> +	u8 *pc = p;
> +	int i, ltmp;
> +
> +	pr_info("%s dumping %s (%d bytes):\n",
> +		PCAN_USB_DRIVER_NAME, prompt ? prompt : "memory", l);
> +	for (i = ltmp = 0; i < l; ) {
> +		ltmp += sprintf(tmp + ltmp, "%02X ", *pc++);
> +		if ((++i % DUMP_WIDTH) == 0) {
> +			pr_info("%s %s\n", PCAN_USB_DRIVER_NAME, tmp);
> +			ltmp = 0;
> +		}
> +	}
> +	if (i % DUMP_WIDTH)
> +		pr_info("%s %s\n", PCAN_USB_DRIVER_NAME, tmp);
> +}

Consider using print_hex_dump() instead.

> +/*
> + * register device timestamp as now
> + */
> +void peak_usb_set_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
> +{
> +	if (time_ref->tv_host_0.tv_sec == 0) {
> +		do_gettimeofday(&time_ref->tv_host_0);

Instead of do_gettimeofday(), it might be better to use ktime_get().  
Unless you have some preference for using WALL_CLOCK rather than 
MONOTONIC_CLOCK.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
