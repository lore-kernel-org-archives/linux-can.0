From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] cangw: Print error message on misspelled interface
Date: Wed, 05 Feb 2014 18:59:38 +0100
Message-ID: <52F27C0A.7030808@hartkopp.net>
References: <1391615310-10731-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:28253 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbaBER7m (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Feb 2014 12:59:42 -0500
In-Reply-To: <1391615310-10731-1-git-send-email-sojkam1@fel.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michal Sojka <sojkam1@fel.cvut.cz>, linux-can@vger.kernel.org



On 05.02.2014 16:48, Michal Sojka wrote:
> If can interface is misspelled or the kernel is configured without netlink
> cangw displayed only generic usage instruction. Now, an appropriate error
> message is displayed.
> 
> Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tnx Michal!

> ---
>  cangw.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/cangw.c b/cangw.c
> index b908fe4..effb7ed 100644
> --- a/cangw.c
> +++ b/cangw.c
> @@ -595,10 +595,18 @@ int main(int argc, char **argv)
>  
>  		case 's':
>  			src_ifindex = if_nametoindex(optarg);
> +			if (src_ifindex == 0) {
> +				perror(optarg);
> +				return 1;
> +			}
>  			break;
>  
>  		case 'd':
>  			dst_ifindex = if_nametoindex(optarg);
> +			if (dst_ifindex == 0) {
> +				perror(optarg);
> +				return 1;
> +			}
>  			break;
>  
>  		case 't':
> 
