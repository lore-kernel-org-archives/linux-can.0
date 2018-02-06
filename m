From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939: Attempt to make j1939 network namespace-aware
Date: Tue, 6 Feb 2018 21:37:52 +0100
Message-ID: <20180206203752.GG1198@airbook.vandijck-laurijssen.be>
References: <CAHChkrvE+uczdhu66snkAt8p2AfgM=sKraaxFJTRDCSXjdS24g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:35475 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbeBFUh4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Feb 2018 15:37:56 -0500
Content-Disposition: inline
In-Reply-To: <CAHChkrvE+uczdhu66snkAt8p2AfgM=sKraaxFJTRDCSXjdS24g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Elenita Hinds <ecathinds@gmail.com>
Cc: linux-can@vger.kernel.org

Hey Elenita,

Great job!
I only have a few minor remarks below.

On ma, 05 feb 2018 14:31:32 -0600, Elenita Hinds wrote:
> Hi all,
> 
> Below is a first attempt to make the j1939 kernel support be network
> namespace-aware (needed for my project). Please review, especially
> Kurt and Marc, as there maybe better ways of doing this. I'll
> re-submit a more official patch after getting feedback/comments.
> 
> Please note the TODO in j1939/transport.c, j1939tp_module_init().
> 
> Regards,
> Elenita Hinds
> 
> ---
> diff --git a/j1939/address-claim.c b/j1939/address-claim.c
> index ab538e1c4906..784e91762c6e 100644
> --- a/j1939/address-claim.c
> +++ b/j1939/address-claim.c
> @@ -89,8 +89,9 @@ int j1939_fixup_address_claim(struct sk_buff *skb)
>          /* return both when failure & when successful */
>          if (ret < 0)
>              return ret;
> -        ecu = j1939_ecu_find_by_name(skcb->addr.src_name,
> -                         skb->dev->ifindex);
> +        ecu = j1939_ecu_find_by_name(dev_net(skb->dev),
> +                                     skcb->addr.src_name,
> +                                     skb->dev->ifindex);
>          if (!ecu)
>              return -ENODEV;
> 
> @@ -100,7 +101,8 @@ int j1939_fixup_address_claim(struct sk_buff *skb)
>          put_j1939_ecu(ecu);
>      } else if (skcb->addr.src_name) {
>          /* assign source address */
> -        sa = j1939_name_to_sa(skcb->addr.src_name, skb->dev->ifindex);
> +        sa = j1939_name_to_sa(dev_net(skb->dev), skcb->addr.src_name,
> +                              skb->dev->ifindex);
>          if (!j1939_address_is_unicast(sa) &&
>              !ac_msg_is_request_for_ac(skb)) {
>              pr_notice("tx drop: invalid sa for name 0x%016llx\n",
> @@ -112,7 +114,8 @@ int j1939_fixup_address_claim(struct sk_buff *skb)
> 
>      /* assign destination address */
>      if (skcb->addr.dst_name) {
> -        sa = j1939_name_to_sa(skcb->addr.dst_name, skb->dev->ifindex);
> +        sa = j1939_name_to_sa(dev_net(skb->dev), skcb->addr.dst_name,
> +                              skb->dev->ifindex);
>          if (!j1939_address_is_unicast(sa)) {
>              pr_notice("tx drop: invalid da for name 0x%016llx\n",
>                       skcb->addr.dst_name);
> @@ -123,7 +126,8 @@ int j1939_fixup_address_claim(struct sk_buff *skb)
>      return 0;
>  }
> 
> -static void j1939_process_address_claim(struct sk_buff *skb, struct
> j1939_priv *priv)
> +static void j1939_process_address_claim(struct sk_buff *skb,
> +                    struct j1939_priv *priv)
>  {
>      struct j1939_sk_buff_cb *skcb = j1939_get_cb(skb);
>      struct j1939_ecu *ecu, *prev;
> diff --git a/j1939/bus.c b/j1939/bus.c
> index 9ba6da216c1b..1af93eb4d939 100644
> --- a/j1939/bus.c
> +++ b/j1939/bus.c
> @@ -110,7 +110,7 @@ struct j1939_ecu *_j1939_ecu_find_by_addr(u8 sa,
> struct j1939_priv *priv)
>      return ecu;
>  }
> 
> -u8 j1939_name_to_sa(name_t name, int ifindex)
> +u8 j1939_name_to_sa(struct net *net, name_t name, int ifindex)
>  {
>      struct j1939_ecu *ecu;
>      struct j1939_priv *priv;
> @@ -118,7 +118,7 @@ u8 j1939_name_to_sa(name_t name, int ifindex)
> 
>      if (!name)
>          return J1939_NO_ADDR;
> -    priv = j1939_priv_get_by_ifindex(ifindex);
> +    priv = j1939_priv_get_by_ifindex(net, ifindex);
>      if (!priv)
>          return J1939_NO_ADDR;
> 
> @@ -157,7 +157,7 @@ static struct j1939_ecu
> *_j1939_ecu_find_by_name(name_t name,
>  }
> 
>  /* ecu lookup by name */
> -struct j1939_ecu *j1939_ecu_find_by_name(name_t name, int ifindex)
> +struct j1939_ecu *j1939_ecu_find_by_name(struct net *net, name_t
> name, int ifindex)
>  {
>      struct j1939_ecu *ecu;
>      struct j1939_priv *priv;
> @@ -166,7 +166,7 @@ struct j1939_ecu *j1939_ecu_find_by_name(name_t
> name, int ifindex)
>          return NULL;
>      if (!ifindex)
>          return NULL;
> -    priv = j1939_priv_get_by_ifindex(ifindex);
> +    priv = j1939_priv_get_by_ifindex(net, ifindex);
>      if (!priv)
>          return NULL;
>      ecu = _j1939_ecu_find_by_name(name, priv);
> diff --git a/j1939/j1939-priv.h b/j1939/j1939-priv.h
> index 2e54092e946a..95288dbc5a90 100644
> --- a/j1939/j1939-priv.h
> +++ b/j1939/j1939-priv.h
> @@ -174,9 +174,9 @@ static inline void j1939_ecu_remove_sa(struct
> j1939_ecu *ecu)
>      write_unlock_bh(&ecu->priv->lock);
>  }
> 
> -u8 j1939_name_to_sa(name_t name, int ifindex);
> +u8 j1939_name_to_sa(struct net *net, name_t name, int ifindex);
>  struct j1939_ecu *_j1939_ecu_find_by_addr(u8 sa, struct j1939_priv *priv);
> -struct j1939_ecu *j1939_ecu_find_by_name(name_t name, int ifindex);
> +struct j1939_ecu *j1939_ecu_find_by_name(struct net *net, name_t
> name, int ifindex);
>  /* find_by_name, with kref & read_lock taken */
>  struct j1939_ecu *j1939_ecu_find_priv_default_tx(int ifindex, name_t *pname,
>                           u8 *paddr);
> @@ -245,12 +245,12 @@ struct j1939_ecu *_j1939_ecu_get_register(struct
> j1939_priv *priv,
>  /* unregister must be called with lock held */
>  void _j1939_ecu_unregister(struct j1939_ecu *);
> 
> -int j1939_netdev_start(struct net_device *);
> -void j1939_netdev_stop(struct net_device *);
> +int j1939_netdev_start(struct net *net, struct net_device *);
> +void j1939_netdev_stop(struct net *net, struct net_device *);
> 
>  void __j1939_priv_release(struct kref *kref);
>  struct j1939_priv *j1939_priv_get(struct net_device *dev);
> -struct j1939_priv *j1939_priv_get_by_ifindex(int ifindex);
> +struct j1939_priv *j1939_priv_get_by_ifindex(struct net *net, int ifindex);
> 
> 
>  static inline void j1939_priv_set(struct net_device *dev, struct
> j1939_priv *priv)
> diff --git a/j1939/main.c b/j1939/main.c
> index 736e9ac8090c..0e55569fb1e6 100644
> --- a/j1939/main.c
> +++ b/j1939/main.c
> @@ -196,7 +196,7 @@ static void j1939_priv_ac_task(unsigned long val)
> 
>  static DEFINE_SPINLOCK(j1939_netdev_lock);
> 
> -int j1939_netdev_start(struct net_device *netdev)
> +int j1939_netdev_start(struct net *net, struct net_device *netdev)
>  {
>      struct j1939_priv *priv;
>      int ret;
> @@ -221,7 +221,7 @@ int j1939_netdev_start(struct net_device *netdev)
>      dev_hold(netdev);
> 
>      /* add CAN handler */
> -    ret = can_rx_register(&init_net, netdev, J1939_CAN_ID, J1939_CAN_MASK,
> +    ret = can_rx_register(net, netdev, J1939_CAN_ID, J1939_CAN_MASK,
>                    j1939_can_recv, priv, "j1939", NULL);
>      if (ret < 0)
>          goto out_dev_put;
> @@ -229,7 +229,8 @@ int j1939_netdev_start(struct net_device *netdev)
>      spin_lock(&j1939_netdev_lock);
>      if (j1939_priv_get(netdev)) {
>          /* Someone was faster than us, use their priv and roll
> -         * back our's. */
> +         * back our's.
> +         */
>          spin_unlock(&j1939_netdev_lock);
>          goto out_rx_unregister;
>      }
> @@ -239,7 +240,7 @@ int j1939_netdev_start(struct net_device *netdev)
>      return 0;
> 
>   out_rx_unregister:
> -    can_rx_unregister(&init_net, netdev, J1939_CAN_ID, J1939_CAN_MASK,
> +    can_rx_unregister(net, netdev, J1939_CAN_ID, J1939_CAN_MASK,
>                j1939_can_recv, priv);
>   out_dev_put:
>      dev_put(netdev);
> @@ -248,12 +249,14 @@ int j1939_netdev_start(struct net_device *netdev)
>      return ret;
>  }
> 
> -void j1939_netdev_stop(struct net_device *netdev)
> +void j1939_netdev_stop(struct net *net, struct net_device *netdev)
>  {
>      struct j1939_priv *priv;
> 
>      spin_lock(&j1939_netdev_lock);
>      priv = __j1939_priv_get(netdev);
> +    can_rx_unregister(net, priv->netdev, J1939_CAN_ID, J1939_CAN_MASK,
> +                      j1939_can_recv, priv);
>      j1939_priv_put(priv);
>      spin_unlock(&j1939_netdev_lock);
>  }
> @@ -264,9 +267,6 @@ void __j1939_priv_release(struct kref *kref)
>      struct j1939_priv *priv = container_of(kref, struct j1939_priv, kref);
>      struct j1939_ecu *ecu;
> 
> -    can_rx_unregister(&init_net, priv->netdev, J1939_CAN_ID, J1939_CAN_MASK,
> -              j1939_can_recv, priv);
> -
>      tasklet_disable_nosync(&priv->ac_task);
> 
>      /* remove pending transport protocol sessions */
> @@ -302,12 +302,12 @@ struct j1939_priv *j1939_priv_get(struct net_device *dev)
>      return priv;
>  }

This looks to me as fixing something and adding namespace support in 1
patch. I think it's better to first add a patch that moves the
can_rx_unregister, seperate from the namespace thing.

> 
> -struct j1939_priv *j1939_priv_get_by_ifindex(int ifindex)
> +struct j1939_priv *j1939_priv_get_by_ifindex(struct net *net, int ifindex)
>  {
>      struct j1939_priv *priv;
>      struct net_device *netdev;
> 
> -    netdev = dev_get_by_index(&init_net, ifindex);
> +    netdev = dev_get_by_index(net, ifindex);
>      if (!netdev)
>          return NULL;
> 
> @@ -321,8 +321,9 @@ static int j1939_netdev_notify(struct notifier_block *nb,
>                     unsigned long msg, void *data)
>  {
>      struct net_device *netdev = netdev_notifier_info_to_dev(data);
> +    struct net *net = dev_net(netdev);
> 
> -    if (!net_eq(dev_net(netdev), &init_net))
> +    if (!net_eq(dev_net(netdev), net))
>          return NOTIFY_DONE;
> 
>      if (netdev->type != ARPHRD_CAN)
> diff --git a/j1939/socket.c b/j1939/socket.c
> index ae5357510623..fe70411cdf88 100644
> --- a/j1939/socket.c
> +++ b/j1939/socket.c
> @@ -200,6 +200,7 @@ static int j1939sk_init(struct sock *sk)
>  static int j1939sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>  {
>      struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
> +    struct sock *sk = sock->sk;
>      struct j1939_sock *jsk = j1939_sk(sock->sk);
>      struct net_device *netdev;
>      struct j1939_priv *priv;
> @@ -219,7 +220,7 @@ static int j1939sk_bind(struct socket *sock,
> struct sockaddr *uaddr, int len)
> 
>      lock_sock(sock->sk);
> 
> -    netdev = dev_get_by_index(&init_net, addr->can_ifindex);
> +    netdev = dev_get_by_index(sock_net(sk), addr->can_ifindex);
>      if (!netdev) {
>          ret = -ENODEV;
>          goto out_release_sock;
> @@ -245,8 +246,8 @@ static int j1939sk_bind(struct socket *sock,
> struct sockaddr *uaddr, int len)
>              goto out_dev_put;
>          }
> 
> -        ret = j1939_netdev_start(netdev);
> -        if (ret < 0)
> +        ret = j1939_netdev_start(sock_net(sk), netdev);
> +        if (ret < 0)
>              goto out_dev_put;
> 
>          jsk->sk.sk_bound_dev_if = addr->can_ifindex;
> @@ -384,14 +385,14 @@ static int j1939sk_release(struct socket *sock)
>          list_del_init(&jsk->list);
>          spin_unlock_bh(&j1939_socks_lock);
> 
> -        netdev = dev_get_by_index(&init_net, jsk->sk.sk_bound_dev_if);
> +        netdev = dev_get_by_index(sock_net(sk), jsk->sk.sk_bound_dev_if);
>          if (netdev) {
>              priv = j1939_priv_get(netdev);
>              j1939_addr_local_put(priv, jsk->addr.sa);
>              j1939_name_local_put(priv, jsk->addr.src_name);
>              j1939_priv_put(priv);
> 
> -            j1939_netdev_stop(netdev);
> +            j1939_netdev_stop(sock_net(sk), netdev);
>              dev_put(netdev);
>          }
>      }
> @@ -457,9 +458,11 @@ static int j1939sk_setsockopt(struct socket
> *sock, int level, int optname,
>          kfree(ofilters);
>          return 0;
>      case SO_J1939_PROMISC:
> -        return j1939sk_setsockopt_flag(jsk, optval, optlen,
> J1939_SOCK_PROMISC);
> +        return j1939sk_setsockopt_flag(jsk, optval, optlen,
> +                    J1939_SOCK_PROMISC);
>      case SO_J1939_RECV_OWN:
> -        return j1939sk_setsockopt_flag(jsk, optval, optlen,
> J1939_SOCK_RECV_OWN);
> +        return j1939sk_setsockopt_flag(jsk, optval, optlen,
> +                    J1939_SOCK_RECV_OWN);
>      case SO_J1939_SEND_PRIO:
>          if (optlen != sizeof(tmp))
>              return -EINVAL;
> @@ -618,7 +621,7 @@ static int j1939sk_sendmsg(struct socket *sock,
> struct msghdr *msg, size_t size)
>              return -EBADFD;
>      }
> 
> -    dev = dev_get_by_index(&init_net, ifindex);
> +    dev = dev_get_by_index(sock_net(sk), ifindex);
>      if (!dev)
>          return -ENXIO;
> 
> @@ -714,7 +717,7 @@ void j1939sk_netdev_event(struct net_device
> *netdev, int error_code)
>              j1939_name_local_put(priv, jsk->addr.src_name);
>              j1939_priv_put(priv);
> 
> -            j1939_netdev_stop(netdev);
> +            j1939_netdev_stop(sock_net(&jsk->sk), netdev);
>          }
>          /* do not remove filters here */
>      }
> diff --git a/j1939/transport.c b/j1939/transport.c
> index fbebcc20bccf..67722773c0b0 100644
> --- a/j1939/transport.c
> +++ b/j1939/transport.c
> @@ -107,8 +107,8 @@ struct session {
>  /* forward declarations */
>  static struct session *j1939_session_new(struct sk_buff *skb);
>  static struct session *j1939_session_fresh_new(int size,
> -                          struct sk_buff *rel_skb,
> -                          pgn_t pgn);
> +                           struct sk_buff *rel_skb,
> +                           pgn_t pgn);
>  static void j1939tp_del_work(struct work_struct *work);

This is not a namespace thing.
Can you remove it.
Maybe add another seperate patch if the whitespace is really better.

> 
>  /* local variables */
> @@ -1152,7 +1152,7 @@ int j1939_send_transport(struct sk_buff *skb)
>          return ret;
> 
>      /* fix dst_flags, it may be used there soon */
> -    priv = j1939_priv_get_by_ifindex(can_skb_prv(skb)->ifindex);
> +    priv = j1939_priv_get_by_ifindex(dev_net(skb->dev),
> can_skb_prv(skb)->ifindex);
>      if (!priv)
>          return -EINVAL;
>      if (j1939_address_is_unicast(cb->addr.da) &&
> @@ -1273,8 +1273,8 @@ int j1939_recv_transport(struct sk_buff *skb)
>  }
> 
>  static struct session *j1939_session_fresh_new(int size,
> -                          struct sk_buff *rel_skb,
> -                          pgn_t pgn)
> +                           struct sk_buff *rel_skb,
> +                           pgn_t pgn)

Only whitespace ...
>  {
>      struct sk_buff *skb;
>      struct j1939_sk_buff_cb *cb;
> @@ -1400,6 +1400,7 @@ static struct ctl_table_header *sysctl_hdr;
>  /* module init */
>  int __init j1939tp_module_init(void)
>  {
> +        //TODO: not sure how to make this network namespace-aware??

The question doesn't belong to the patch, but is valid.
I don't have the answer. I suggest to make the j1939 sysctl
not namespace-aware for a moment, and anyone who does not agree will
know how to fix it?

>      sysctl_hdr = register_net_sysctl(&init_net, "net/can-j1939",
>                       canj1939_sysctl_table);
>      if (!sysctl_hdr)
> 
> 
> ---
