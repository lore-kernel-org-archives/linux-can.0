From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: receiving CAN from remote hosts only
Date: Thu, 23 Aug 2012 10:40:37 +0200
Message-ID: <20120823084037.GD456@vandijck-laurijssen.be>
References: <OF5F6ABAA1.C0168430-ONC1257A5D.003ADDEA-C1257A5D.003C4200@continental-corporation.com>
 <1899121230.725766.1345205637801.JavaMail.open-xchange@webmail.strato.de>
 <20120822085708.GB420@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:23071 "EHLO
	mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751833Ab2HWIlG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Aug 2012 04:41:06 -0400
Content-Disposition: inline
In-Reply-To: <20120822085708.GB420@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, Mahesh.Maharjan-EXT@continental-corporation.com

Mahesh,

I realize that I only mentioned the MSG_DONTROUTE flags, but did not
provide any clue how to get started.

If I understand your problem well, your transmitting part is working
well using CAN_BCM, and you want to receive all traffic from remote hosts
only, using CAN_RAW as Oliver suggested.

I you read this,

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=1e55659ce6ddb5247cee0b1f720d77a799902b85

you will notice the use of MSG_DONTROUTE.
You need to use recvmsg() instead of recv(). You can see an example use
of recvmsg() in candump.c.

Your receive loop could then look as follows:

	struct msghdr msg;

	while (1) {
		...
		msg.msg_flags = 0;
		....

		ret = recvfrom(cansock, &msg, 0);

		if (msg.msg_flags & MSG_DONTROUTE)
			/* frame from localhost */
			continue;

		/* do some stuff with frame from remote host */
	}

I hope you will find a solution ...

Kind regards,
Kurt

On Wed, Aug 22, 2012 at 10:57:08AM +0200, Kurt Van Dijck wrote:
> Oliver,
> 
> I did not follow this thread in depth.
> 
> The patch looks minimal, but I doubt its usefullness.
> In a proper designed CAN system, each node uses distinct CAN-ids.
> Therefore, filtering out local traffic can always be accomplished
> with the current filtering (RTR frames are an exception, but are
> irrelevant here).
> 
> userspace can test flags (MSG_DONTROUTE) to decide if a received
> frame is from <localhost> or remote.
> So I don't see the problem that you're addressing with this patch.
> 
> Kind regards,
> Kurt
> 
> On Fri, Aug 17, 2012 at 02:13:57PM +0200, Oliver Hartkopp wrote:
> > Hello Mahesh,
> > 
> > i tried to generate a patch that allows you to disable the reception of local
> > generated CAN messages.
> > 
> > The patch is based on Kernel 3.6-rc2 - but it should be easy to backport by
> > hand.
> > 
> > Can you try it, if it solves your problem?
> > 
> > Maybe this extension to the CAN_RAW socket is useful for other people also ...
> > 
> > Regards,
> > Oliver
> > 
> > diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
> > index 820f553..b6d28bd 100644
> > --- a/Documentation/networking/can.txt
> > +++ b/Documentation/networking/can.txt
> > @@ -23,7 +23,8 @@ This file contains
> >        4.1.3 RAW socket option CAN_RAW_LOOPBACK
> >        4.1.4 RAW socket option CAN_RAW_RECV_OWN_MSGS
> >        4.1.5 RAW socket option CAN_RAW_FD_FRAMES
> > -      4.1.6 RAW socket returned message flags
> > +      4.1.6 RAW socket option CAN_RAW_RECV_HOST_MSGS
> > +      4.1.7 RAW socket returned message flags
> >      4.2 Broadcast Manager protocol sockets (SOCK_DGRAM)
> >      4.3 connected transport protocols (SOCK_SEQPACKET)
> >      4.4 unconnected transport protocols (SOCK_DGRAM)
> > @@ -581,7 +582,23 @@ solution for a couple of reasons:
> >    CAN FD frames by checking if the device maximum transfer unit is CANFD_MTU.
> >    The CAN device MTU can be retrieved e.g. with a SIOCGIFMTU ioctl() syscall.
> > 
> > -  4.1.6 RAW socket returned message flags
> > +  4.1.6 RAW socket option CAN_RAW_RECV_HOST_MSGS
> > +
> > +  When the local loopback is enabled, all the sent CAN frames are
> > +  looped back to the open CAN sockets that registered for the CAN
> > +  frames' CAN-ID on this given interface to meet the multi user
> > +  needs. The reception of the CAN frames originated from the local host
> > +  is therefore a wanted behaviour and enabled by default.
> > +
> > +  When the reception of locally generated CAN frames is not wanted, this
> > +  default behaviour may be changed on demand:
> > +
> > +    int recv_host_msgs = 0; /* 0 = disabled, 1 = enabled (default) */
> > +
> > +    setsockopt(s, SOL_CAN_RAW, CAN_RAW_RECV_HOST_MSGS,
> > +               &recv_host_msgs, sizeof(recv_host_msgs));
> > +
> > +  4.1.7 RAW socket returned message flags
> > 
> >    When using recvmsg() call, the msg->msg_flags may contain following flags:
> > 
> > diff --git a/include/linux/can/raw.h b/include/linux/can/raw.h
> > index a814062..0d53fb6 100644
> > --- a/include/linux/can/raw.h
> > +++ b/include/linux/can/raw.h
> > @@ -25,6 +25,7 @@ enum {
> >         CAN_RAW_LOOPBACK,       /* local loopback (default:on)       */
> >         CAN_RAW_RECV_OWN_MSGS,  /* receive my own msgs (default:off) */
> >         CAN_RAW_FD_FRAMES,      /* allow CAN FD frames (default:off) */
> > +       CAN_RAW_RECV_HOST_MSGS, /* recv local host msgs (default:on) */
> >  };
> > 
> >  #endif
> > diff --git a/net/can/raw.c b/net/can/raw.c
> > index 3e9c893..0cfbc16 100644
> > --- a/net/can/raw.c
> > +++ b/net/can/raw.c
> > @@ -83,6 +83,7 @@ struct raw_sock {
> >         int loopback;
> >         int recv_own_msgs;
> >         int fd_frames;
> > +       int recv_host_msgs;
> >         int count;                 /* number of active filters */
> >         struct can_filter dfilter; /* default/single filter */
> >         struct can_filter *filter; /* pointer to filter(s) */
> > @@ -120,6 +121,10 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
> >         if (!ro->recv_own_msgs && oskb->sk == sk)
> >                 return;
> > 
> > +       /* check if we need to skip locally generated messages */
> > +       if (!ro->recv_host_msgs && oskb->sk)
> > +               return;
> > +
> >         /* do not pass frames with DLC > 8 to a legacy socket */
> >         if (!ro->fd_frames) {
> >                 struct canfd_frame *cfd = (struct canfd_frame *)oskb->data;
> > @@ -301,6 +306,7 @@ static int raw_init(struct sock *sk)
> >         ro->loopback         = 1;
> >         ro->recv_own_msgs    = 0;
> >         ro->fd_frames        = 0;
> > +       ro->recv_host_msgs   = 1;
> > 
> >         /* set notifier */
> >         ro->notifier.notifier_call = raw_notifier;
> > @@ -588,6 +594,15 @@ static int raw_setsockopt(struct socket *sock, int level,
> > int optname,
> > 
> >                 break;
> > 
> > +       case CAN_RAW_RECV_HOST_MSGS:
> > +               if (optlen != sizeof(ro->recv_host_msgs))
> > +                       return -EINVAL;
> > +
> > +               if (copy_from_user(&ro->recv_host_msgs, optval, optlen))
> > +                       return -EFAULT;
> > +
> > +               break;
> > +
> >         default:
> >                 return -ENOPROTOOPT;
> >         }
> > @@ -652,6 +667,12 @@ static int raw_getsockopt(struct socket *sock, int level,
> > int optname,
> >                 val = &ro->fd_frames;
> >                 break;
> > 
> > +       case CAN_RAW_RECV_HOST_MSGS:
> > +               if (len > sizeof(int))
> > +                       len = sizeof(int);
> > +               val = &ro->recv_host_msgs;
> > +               break;
> > +
> >         default:
> >                 return -ENOPROTOOPT;
> >         }
> > 
> > 
> > 
> > 
> > Mahesh.Maharjan-EXT@continental-corporation.com hat am 17. August 2012 um 12:58
> > geschrieben:> hello to all,
> > > 
> > > Thanks to Oliver.  Suggesting for using both RAW n' BCM together .
> > >
> > > But As Already discussed by Daniele Venzano : The loopback problems  are
> > > occurring , When Sending can_message from BCM , RAW also  trying to read
> > > all message  dynamically. ( Suppose we don't need filter in system).And  I
> > > want to ignore all message  coming to same my node Again.  Even I used
> > > same  option  for setting "loopback mode"in raw socket.  But suggestion
> > > mention by Daniele. : can_send(skb, 1)  from bcm.c. Sound pretty simple.
> > > But doesn't look better to change directly from source code. Yeah , Even I
> > > changed for testing .. "no work done "....
> > >
> > > Help  !!!
> > >
> > >
> > > With Regards,
> > >
> > > Mahesh Maharjan
> > >
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-can" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> > diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
> > index 820f553..b6d28bd 100644
> > --- a/Documentation/networking/can.txt
> > +++ b/Documentation/networking/can.txt
> > @@ -23,7 +23,8 @@ This file contains
> >        4.1.3 RAW socket option CAN_RAW_LOOPBACK
> >        4.1.4 RAW socket option CAN_RAW_RECV_OWN_MSGS
> >        4.1.5 RAW socket option CAN_RAW_FD_FRAMES
> > -      4.1.6 RAW socket returned message flags
> > +      4.1.6 RAW socket option CAN_RAW_RECV_HOST_MSGS
> > +      4.1.7 RAW socket returned message flags
> >      4.2 Broadcast Manager protocol sockets (SOCK_DGRAM)
> >      4.3 connected transport protocols (SOCK_SEQPACKET)
> >      4.4 unconnected transport protocols (SOCK_DGRAM)
> > @@ -581,7 +582,23 @@ solution for a couple of reasons:
> >    CAN FD frames by checking if the device maximum transfer unit is CANFD_MTU.
> >    The CAN device MTU can be retrieved e.g. with a SIOCGIFMTU ioctl() syscall.
> >  
> > -  4.1.6 RAW socket returned message flags
> > +  4.1.6 RAW socket option CAN_RAW_RECV_HOST_MSGS
> > +
> > +  When the local loopback is enabled, all the sent CAN frames are
> > +  looped back to the open CAN sockets that registered for the CAN
> > +  frames' CAN-ID on this given interface to meet the multi user
> > +  needs. The reception of the CAN frames originated from the local host
> > +  is therefore a wanted behaviour and enabled by default.
> > +
> > +  When the reception of locally generated CAN frames is not wanted, this
> > +  default behaviour may be changed on demand:
> > +
> > +    int recv_host_msgs = 0; /* 0 = disabled, 1 = enabled (default) */
> > +
> > +    setsockopt(s, SOL_CAN_RAW, CAN_RAW_RECV_HOST_MSGS,
> > +               &recv_host_msgs, sizeof(recv_host_msgs));
> > +
> > +  4.1.7 RAW socket returned message flags
> >  
> >    When using recvmsg() call, the msg->msg_flags may contain following flags:
> >  
> > diff --git a/include/linux/can/raw.h b/include/linux/can/raw.h
> > index a814062..0d53fb6 100644
> > --- a/include/linux/can/raw.h
> > +++ b/include/linux/can/raw.h
> > @@ -25,6 +25,7 @@ enum {
> >  	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
> >  	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
> >  	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
> > +	CAN_RAW_RECV_HOST_MSGS,	/* recv local host msgs (default:on) */
> >  };
> >  
> >  #endif
> > diff --git a/net/can/raw.c b/net/can/raw.c
> > index 3e9c893..0cfbc16 100644
> > --- a/net/can/raw.c
> > +++ b/net/can/raw.c
> > @@ -83,6 +83,7 @@ struct raw_sock {
> >  	int loopback;
> >  	int recv_own_msgs;
> >  	int fd_frames;
> > +	int recv_host_msgs;
> >  	int count;                 /* number of active filters */
> >  	struct can_filter dfilter; /* default/single filter */
> >  	struct can_filter *filter; /* pointer to filter(s) */
> > @@ -120,6 +121,10 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
> >  	if (!ro->recv_own_msgs && oskb->sk == sk)
> >  		return;
> >  
> > +	/* check if we need to skip locally generated messages */
> > +	if (!ro->recv_host_msgs && oskb->sk)
> > +		return;
> > +
> >  	/* do not pass frames with DLC > 8 to a legacy socket */
> >  	if (!ro->fd_frames) {
> >  		struct canfd_frame *cfd = (struct canfd_frame *)oskb->data;
> > @@ -301,6 +306,7 @@ static int raw_init(struct sock *sk)
> >  	ro->loopback         = 1;
> >  	ro->recv_own_msgs    = 0;
> >  	ro->fd_frames        = 0;
> > +	ro->recv_host_msgs   = 1;
> >  
> >  	/* set notifier */
> >  	ro->notifier.notifier_call = raw_notifier;
> > @@ -588,6 +594,15 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
> >  
> >  		break;
> >  
> > +	case CAN_RAW_RECV_HOST_MSGS:
> > +		if (optlen != sizeof(ro->recv_host_msgs))
> > +			return -EINVAL;
> > +
> > +		if (copy_from_user(&ro->recv_host_msgs, optval, optlen))
> > +			return -EFAULT;
> > +
> > +		break;
> > +
> >  	default:
> >  		return -ENOPROTOOPT;
> >  	}
> > @@ -652,6 +667,12 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
> >  		val = &ro->fd_frames;
> >  		break;
> >  
> > +	case CAN_RAW_RECV_HOST_MSGS:
> > +		if (len > sizeof(int))
> > +			len = sizeof(int);
> > +		val = &ro->recv_host_msgs;
> > +		break;
> > +
> >  	default:
> >  		return -ENOPROTOOPT;
> >  	}
> 
> 
> -- 
> Kurt Van Dijck
> GRAMMER EiA ELECTRONICS
> http://www.eia.be
> kurt.van.dijck@eia.be
> +32-38708534

-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
