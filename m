From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] canplayer: convert skipgap to unsigned long
Date: Fri, 10 Apr 2015 11:29:11 +0200
Message-ID: <552797E7.9000304@hartkopp.net>
References: <1428613281-21827-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:51900 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571AbbDJJ3V (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Apr 2015 05:29:21 -0400
In-Reply-To: <1428613281-21827-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>, linux-can@vger.kernel.org



On 09.04.2015 23:01, Yegor Yefremov wrote:
> The result of (last_log_tv.tv_sec - log_tv.tv_sec) is
> unsigned long, so use labs() in order not to trim the
> value to int. Make skipgap to unsigned long for the same
> reason.
>

Yes. And additionally

	skipgap = strtoul(optarg, NULL, 10);

should have pointed me to use unsigned long m)

Thanks Yegor!

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Regards,
Oliver

> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>   canplayer.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/canplayer.c b/canplayer.c
> index f74668e..437ed4b 100644
> --- a/canplayer.c
> +++ b/canplayer.c
> @@ -86,7 +86,7 @@ void print_usage(char *prg)
>   		"send frames immediately)\n");
>   	fprintf(stderr, "                      -g <ms>      (gap in milli "
>   		"seconds - default: %d ms)\n", DEFAULT_GAP);
> -	fprintf(stderr, "                      -s <s>      (skip gaps in "
> +	fprintf(stderr, "                      -s <s>       (skip gaps in "
>   		"timestamps > 's' seconds)\n");
>   	fprintf(stderr, "                      -x           (disable local "
>   		"loopback of sent CAN frames)\n");
> @@ -241,7 +241,8 @@ int main(int argc, char **argv)
>   	FILE *infile = stdin;
>   	unsigned long gap = DEFAULT_GAP;
>   	int use_timestamps = 1;
> -	static int verbose, opt, delay_loops, skipgap;
> +	static int verbose, opt, delay_loops;
> +	static unsigned long skipgap;
>   	static int loopback_disable = 0;
>   	static int infinite_loops = 0;
>   	static int loops = DEFAULT_LOOPS;
> @@ -482,7 +483,7 @@ int main(int argc, char **argv)
>   					/* test for logfile timestamps jumping backwards OR      */
>   					/* if the user likes to skip long gaps in the timestamps */
>   					if ((last_log_tv.tv_sec > log_tv.tv_sec) ||
> -					    (skipgap && abs(last_log_tv.tv_sec - log_tv.tv_sec) > skipgap))
> +					    (skipgap && labs(last_log_tv.tv_sec - log_tv.tv_sec) > skipgap))
>   						create_diff_tv(&today_tv, &diff_tv, &log_tv);
>
>   					last_log_tv = log_tv;
>
