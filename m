From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH] can: remove CAN FD compatibility for CAN 2.0 sockets
Date: Fri, 28 Feb 2014 16:23:23 +0100
Message-ID: <5310A9EB.7050102@peak-system.com>
References: <530F9D39.1010500@hartkopp.net>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:40197 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbaB1PXo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 10:23:44 -0500
In-Reply-To: <530F9D39.1010500@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

I agree with this change, so you also have my Acked-by ...

Le 27/02/2014 21:16, Oliver Hartkopp a =E9crit :
> In commit e2d265d3b587 (canfd: add support for CAN FD in CAN_RAW sock=
ets)
> CAN FD frames with a payload length up to 8 byte are passed to legacy
> sockets where the CAN FD support was not enabled by the application.
>
> After some discussions with developers at a fair this well meant feat=
ure
> leads to confusion as no clean switch for CAN / CAN FD is provided to=
 the
> application programmer. Additionally a compatibility like this for le=
gacy
> CAN_RAW sockets requires some compatibility handling for the sending,=
 e.g.
> make CAN2.0 frames a CAN FD frame with BRS at transmission time (?!?)=
=2E
>
> This will become a mess when people start to develop applications wit=
h
> real CAN FD hardware. This patch reverts the bad compatibility code.
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 8be757c..081e81f 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -121,13 +121,9 @@ static void raw_rcv(struct sk_buff *oskb, void *=
data)
>   	if (!ro->recv_own_msgs && oskb->sk =3D=3D sk)
>   		return;
>  =20
> -	/* do not pass frames with DLC > 8 to a legacy socket */
> -	if (!ro->fd_frames) {
> -		struct canfd_frame *cfd =3D (struct canfd_frame *)oskb->data;
> -
> -		if (unlikely(cfd->len > CAN_MAX_DLEN))
> -			return;
> -	}
> +	/* do not pass non-CAN2.0 frames to a legacy socket */
> +	if (!ro->fd_frames && oskb->len !=3D CAN_MTU)
> +		return;
>  =20
>   	/* clone the given skb to be able to enqueue it into the rcv queue=
 */
>   	skb =3D skb_clone(oskb, GFP_ATOMIC);
> @@ -738,9 +734,7 @@ static int raw_recvmsg(struct kiocb *iocb, struct=
 socket *sock,
>   		       struct msghdr *msg, size_t size, int flags)
>   {
>   	struct sock *sk =3D sock->sk;
> -	struct raw_sock *ro =3D raw_sk(sk);
>   	struct sk_buff *skb;
> -	int rxmtu;
>   	int err =3D 0;
>   	int noblock;
>  =20
> @@ -751,20 +745,10 @@ static int raw_recvmsg(struct kiocb *iocb, stru=
ct socket *sock,
>   	if (!skb)
>   		return err;
>  =20
> -	/*
> -	 * when serving a legacy socket the DLC <=3D 8 is already checked i=
nside
> -	 * raw_rcv(). Now check if we need to pass a canfd_frame to a legac=
y
> -	 * socket and cut the possible CANFD_MTU/CAN_MTU length to CAN_MTU
> -	 */
> -	if (!ro->fd_frames)
> -		rxmtu =3D CAN_MTU;
> -	else
> -		rxmtu =3D skb->len;
> -
> -	if (size < rxmtu)
> +	if (size < skb->len)
>   		msg->msg_flags |=3D MSG_TRUNC;
>   	else
> -		size =3D rxmtu;
> +		size =3D skb->len;
>  =20
>   	err =3D memcpy_toiovec(msg->msg_iov, skb->data, size);
>   	if (err < 0) {
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
