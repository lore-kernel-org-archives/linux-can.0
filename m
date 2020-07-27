From: "Jason A. Donenfeld" <Jason-OnJsPKxuuEcAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 12/26] netfilter: switch nf_setsockopt to sockptr_t
Date: Mon, 27 Jul 2020 17:03:10 +0200
Message-ID: <20200727150310.GA1632472@zx2c4.com>
References: <20200723060908.50081-1-hch@lst.de>
 <20200723060908.50081-13-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200723060908.50081-13-hch-jcswGhMUV9g@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Jakub Kicinski <kuba-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexei Starovoitov <ast-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, Alexey Kuznetsov <kuznet-v/Mj1YrvjDBInbfyfbPRSQ@public.gmane.org>, Hideaki YOSHIFUJI <yoshfuji-VfPWfsRibaP+Ru+s062T9g@public.gmane.org>, Eric Dumazet <edumazet-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-crypto-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bpf-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netfilter-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, coreteam-Cap9r6Oaw4JrovVCs/uTlw@public.gmane.org, linux-sctp-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hams-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bridge-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dccp-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-decnet-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-wpan-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mptcp-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, lvs-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rds-devel@oss.o
List-Id: linux-can.vger.kernel.org

Hi Christoph,

On Thu, Jul 23, 2020 at 08:08:54AM +0200, Christoph Hellwig wrote:
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index da933f99b5d517..42befbf12846c0 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -1422,7 +1422,8 @@ int ip_setsockopt(struct sock *sk, int level,
>  			optname != IP_IPSEC_POLICY &&
>  			optname != IP_XFRM_POLICY &&
>  			!ip_mroute_opt(optname))
> -		err = nf_setsockopt(sk, PF_INET, optname, optval, optlen);
> +		err = nf_setsockopt(sk, PF_INET, optname, USER_SOCKPTR(optval),
> +				    optlen);
>  #endif
>  	return err;
>  }
> diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
> index 4697d09c98dc3e..f2a9680303d8c0 100644
> --- a/net/ipv4/netfilter/ip_tables.c
> +++ b/net/ipv4/netfilter/ip_tables.c
> @@ -1102,7 +1102,7 @@ __do_replace(struct net *net, const char *name, unsigned int valid_hooks,
>  }
>  
>  static int
> -do_replace(struct net *net, const void __user *user, unsigned int len)
> +do_replace(struct net *net, sockptr_t arg, unsigned int len)
>  {
>  	int ret;
>  	struct ipt_replace tmp;
> @@ -1110,7 +1110,7 @@ do_replace(struct net *net, const void __user *user, unsigned int len)
>  	void *loc_cpu_entry;
>  	struct ipt_entry *iter;
>  
> -	if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)
> +	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
>  		return -EFAULT;
>  
>  	/* overflow check */
> @@ -1126,8 +1126,8 @@ do_replace(struct net *net, const void __user *user, unsigned int len)
>  		return -ENOMEM;
>  
>  	loc_cpu_entry = newinfo->entries;
> -	if (copy_from_user(loc_cpu_entry, user + sizeof(tmp),
> -			   tmp.size) != 0) {
> +	sockptr_advance(arg, sizeof(tmp));
> +	if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) != 0) {
>  		ret = -EFAULT;
>  		goto free_newinfo;
>  	}

Something along this path seems to have broken with this patch. An
invocation of `iptables -A INPUT -m length --length 1360 -j DROP` now
fails, with

nf_setsockopt->do_replace->translate_table->check_entry_size_and_hooks:
  (unsigned char *)e + e->next_offset > limit  ==>  TRUE

resulting in the whole call chain returning -EINVAL. It bisects back to
this commit. This is on net-next.

Jason
