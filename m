Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2BD388396;
	Tue, 13 Oct 2026 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884136; cv=none; b=O/7zlCkUNm1vGPZNpeSPz2smFsh5LXVX+oTIqUSkseAx4j6njRb0cpmUbfnARrON3WCv2raCGnjqH+gcoIRd/oFWHz3DSX3iJkSi5oYOQ9OxMeCVNmAz36ik6ldGX4ZHXQaIv8u/JnA5PJMSW++QsZlkYK7MNLGI6EtXmNkBBwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884136; c=relaxed/simple;
	bh=S6BusWRy8Of5/RupOF5OofPZm7twIbe+NLd1Y1HAfyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwoK+klOBkdVZHa/ffYULYM34ECIca0NSO4audQF8xXfznSWRyYthlqHzbDSagsXpr7GhSzqBSd2QAx+VmyC+xWpmb7P4VoNHfLktUH+MwSUao+DJn01JuUuSJufOInVIVLP3oNlldqiUTFtExwe+908HY5HWexwMMMZk2nhaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=Re8oeK2Y; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="Re8oeK2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1791884125; x=1792488925;
	i=alexander.hoelzl@gmx.net;
	bh=8tgpNXhpw1xFFxaxbUnLBEGEfLFyz+MWucdfUk7WRpU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Re8oeK2Yk+KtCvXWKdsoNyZxCunD/vswqFHSO3wrNyu5IqY0OrzG/PCHk0iOYjhl
	 gX9n1wK7kpYMgmXIYPX3ODU1dtPlm7439MJPya3umv1SIDnHIzFjtTVctZ7YM59Gi
	 6NYz6N3lSrvJ11ax/Q3C6TGcHkdTO9Fa/8NocDM9vmt7pk2LzryO4285t60SYSacs
	 xFXKY+srsmWHK0noeDTIOBeIlOYhbCvcxb/1B1HbbHrDl94vwx+ZDMQYcCRf62bCm
	 OeWkGPHoSG4nPn4vjUxp5H+W8j4Ozh+hifyaOgcL8G4Rjos+tRs8kA1Bc+pKHDQsj
	 Jbj3Wram0X9Jv5I25w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiacH-1wkmnS1VXb-00oMEm; Tue, 13
 Oct 2026 11:35:25 +0200
Message-ID: <fda0ca77-ecfe-4f95-a469-05cbc416944a@gmx.net>
Date: Tue, 13 Oct 2026 11:35:24 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] can: j1939: fix potential race condition in BAM
 segmentation
To: netdev-bot+sashiko@kernel.org
Cc: o.rempel@pengutronix.de, robin@protonic.nl, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, linux-can@vger.kernel.org, kuba@kernel.org
References: <20261011153119.120302-1-alexander.hoelzl@gmx.net>
 <179186737069.1406898.4501392866752412525@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?H=C3=B6lzl=2C_Alexander?= <alexander.hoelzl@gmx.net>
In-Reply-To: <179186737069.1406898.4501392866752412525@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LxFsWEM1zmIbjB7s/PKqPerztdKgRyP45E6YblkKB0dmhFRK868
 G+nhjAcY+CNIDNBPzoC2pjy9eAtbAiEznNAPJ3QSYef4DLyZRqxh/SHL1HsJQd/Tl6HRZlR
 tDepD0G9T/Eb38LYGzdbdTMCDbeNW1eOBYfmOJ3TZO3jw9fGXHIgr9ihX6V9ycZXU+d/nm7
 qMq5hG+EHmLYanavES+6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XYgzHs/qo6o=;OIdJyiJFV3Q/kBLKPgGJq5VAOu4
 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
 QXi+51n4iPVg2Hnnd9tI=



Am 13.10.2026 um 06:56 schrieb netdev-bot+sashiko@kernel.org:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 3 =C2=B7 Low: 2
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwo=
rk
> know by including "pw-bot: cr" as a separate line at the end of your rep=
ly
> (one such reply per series is enough).
>=20
> - [Medium] The new BAM-transmitter echo branches can bring an aborted
>    session back to life.
> - [Medium] Forged TP.DT frames can stall a BAM transmission for as long
>    as they keep coming, and it never times out.
> - [Medium] The new re-arm in the RX path (cancel, then schedule) is not
>    atomic and holds no lock, so it can leak session references.
> - [Low] The commit message understates the bug and has no Fixes: tag.
> - [Low] The new J1939_TP_BAM_ECHO_TIMEOUT_MS (250) constant does not
>    control the timeouts that actually wait for an echo.
>=20
> --
>=20
> can: j1939: fix potential race condition in BAM segmentation
>=20
> This patch moves txtimer scheduling for BAM transmissions out of the
> transmit path and into the echo (tx ack) handlers. The 50ms frame spacin=
g
> timer is now armed in j1939_xtp_rx_rts() and j1939_xtp_rx_dat_one() when
> the looped back BAM or DT frame arrives, instead of in
> j1939_session_tx_rts() and j1939_session_tx_dat().
>=20
>> If there is a high busload and the BAM frame is stuck in the controller
>> for some time, the txtimer might elapse before the looped back frame is
>> received and the session will stall.
>=20
> [Severity: Low]
> Is "stall" the right word for what happens before this patch?
>=20
> If the 50ms txtimer fires before the BAM echo arrives, last_cmd is still=
 0.
> j1939_xtp_txnext_transmiter() then calls j1939_session_tx_rts() again, a=
nd
> that call returns early:
>=20
> 	if (dat[0] =3D=3D session->last_txcmd)
> 		/* done already */
> 		return 0;
>=20
> Nothing re-arms the txtimer after that. The 250ms rxtimer armed in
> j1939_session_tx_rts() then fires, and j1939_tp_rxtimer() aborts the
> session:
>=20
> 	__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
>=20
> So user space sees the transfer aborted with EHOSTUNREACH, not a stall.
> Could the commit message describe that?
>=20
> This also fixes behaviour that goes back to the original J1939 code. Sho=
uld
> it carry this tag so stable picks it up?
>=20
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
>=20

I called it stall because that's how it looks like when looking at the=20
bus traces. The tag I can add as well.>> diff --git=20
a/net/can/j1939/transport.c b/net/can/j1939/transport.c
>> index 8fcfd13e5e6f8..c61a021880c01 100644
>> --- a/net/can/j1939/transport.c
>> +++ b/net/can/j1939/transport.c
>=20
> [ ... ]
>=20
>> @@ -26,6 +25,9 @@
>>   #define J1939_TP_CMD_BAM 0x20
>>   #define J1939_TP_CMD_ABORT 0xff
>>  =20
>> +#define J1939_TP_BAM_FRAME_SPACING_MS 50
>> +#define J1939_TP_BAM_ECHO_TIMEOUT_MS 250
>=20
> [Severity: Low]
> This isn't a bug, but J1939_TP_BAM_ECHO_TIMEOUT_MS does not seem to set =
the
> timeouts that actually wait for an echo. Those still use a bare 250.
>=20
> In j1939_session_tx_rts(), after the BAM is sent:
>=20
> 	if (dat[0] =3D=3D J1939_TP_CMD_BAM) {
> 		j1939_tp_set_rxtimeout(session, 250);

In this case the macro should probably used to be consistent.

>=20
> In j1939_session_tx_dat(), after each DT frame:
>=20
> 	if (pkt_done)
> 		j1939_tp_set_rxtimeout(session, 250);
>=20
> The macro is only used in j1939_xtp_rx_rts() and j1939_xtp_rx_dat_one().
> Both run after the echo has already arrived, and j1939_session_tx_dat()
> overwrites that rxtimer about 50ms later.
>=20
> Should the echo wait sites use the macro instead?

In my patch, I'm scheduling the rxtimeout in the rx functions when the=20
corresponding frame is received. It would be cleaner to do it in=20
j1939_session_tx_dat and get rid of the calls to j1939_tp_set_rxtimeout=20
I've added. The J1939_TP_BAM_ECHO_TIMEOUT_MS macro should then probably=20
be renamed to be a generic J1939_TP_ECHO_TIMEOUT_MS and can then be used=
=20
in j1939_session_tx_rts and j1939_session_tx_dat.

>=20
>> +
>>   #define J1939_ETP_CMD_RTS 0x14
>=20
> [ ... ]
>=20
>> @@ -1806,8 +1814,13 @@ static void j1939_xtp_rx_rts(struct j1939_priv *=
priv, struct sk_buff *skb,
>>   	session->last_cmd =3D cmd;
>>  =20
>>   	if (cmd =3D=3D J1939_TP_CMD_BAM) {
>> -		if (!session->transmission)
>> +		if (!session->transmission) {
>>   			j1939_tp_set_rxtimeout(session, 750);
>> +		} else {
>> +			j1939_session_txtimer_cancel(session);
>> +			j1939_tp_schedule_txtimer(session, J1939_TP_BAM_FRAME_SPACING_MS);
>> +			j1939_tp_set_rxtimeout(session, J1939_TP_BAM_ECHO_TIMEOUT_MS);
>> +		}
>=20
> [Severity: Medium]
> Can a late echo bring an aborted session back to life here? The same
> question applies to the new branch in j1939_xtp_rx_dat_one().
>=20
> Both branches re-arm the txtimer and rxtimer without
> active_session_list_lock and without checking session->state. Under the
> bus load this patch targets, a BAM or DT echo can arrive more than 250ms
> late. By then j1939_tp_rxtimer() has already taken the abort path under =
the
> list lock:
>=20
> j1939_tp_rxtimer()
>      j1939_session_list_lock(session->priv);
>      ...
>          hrtimer_start(&session->rxtimer,
>                        ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
>                        HRTIMER_MODE_REL_SOFT);
>          __j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
>=20
> That sets J1939_SESSION_WAITING_ABORT, sets err to EHOSTUNREACH and arms
> the forced deactivation timer.
>=20
> The session is still on active_session_list, so the late echo is still
> delivered here. j1939_tp_set_rxtimeout() then cancels the abort rxtimer =
and
> replaces it with a normal 250ms one. The txtimer fires 50ms later:
>=20
> j1939_tp_txtimer()
>    j1939_xtp_txnext_transmiter()
>      j1939_session_tx_dat()
>=20
> None of these check session->state. More DT frames therefore go out for =
a
> session that was already reported as aborted.
>=20
> Each of those echoes goes through the same re-arm in
> j1939_xtp_rx_dat_one(), which pushes the forced deactivation back again.
> The session can even reach j1939_session_completed() after user space wa=
s
> told the transfer was aborted.
>=20
> There also seems to be a narrower window against
> j1939_cancel_active_session() (socket close or NETDEV_DOWN). It cancels =
the
> timers under active_session_list_lock:
>=20
> 	if (hrtimer_try_to_cancel(&session->txtimer) =3D=3D 1)
> 		j1939_session_put(session);
>=20
> The RX path still holds the reference from j1939_session_get_by_addr(). =
If
> it re-arms after this point, one more frame is sent for a session in
> J1939_SESSION_DONE.
>=20
> Before this patch, the BAM transmitter echo path only updated last_cmd a=
nd
> pkt.rx. Should these new branches check session->state under the list lo=
ck
> before re-arming?
>=20
> [ ... ]

This sounds plausible, I can add the checks.

>=20
>> @@ -1961,6 +1974,12 @@ static void j1939_xtp_rx_dat_one(struct j1939_se=
ssion *session,
>>   	} else if (remain) {
>>   		if (!session->transmission)
>>   			j1939_tp_set_rxtimeout(session, 750);
>> +		else if (j1939_cb_is_broadcast(&session->skcb)) {
>> +			/* cancel the txtimer to avoid leaking session references */
>> +			j1939_session_txtimer_cancel(session);
>> +			j1939_tp_schedule_txtimer(session, J1939_TP_BAM_FRAME_SPACING_MS);
>> +			j1939_tp_set_rxtimeout(session, J1939_TP_BAM_ECHO_TIMEOUT_MS);
>> +		}
>=20
> [Severity: Medium]
> Can forged TP.DT frames hold off a BAM transmission indefinitely here?
>=20
> j1939_can_recv() sets J1939_ECU_LOCAL_SRC based only on the SA:
>=20
> 	if (j1939_address_is_unicast(skcb->addr.sa) &&
> 	    priv->ents[skcb->addr.sa].nusers)
> 		skcb->flags |=3D J1939_ECU_LOCAL_SRC;
>=20
> So j1939_xtp_rx_dat() routes any TP.DT frame with the host's SA and DA 0=
xff
> to the transmitter session's j1939_xtp_rx_dat_one(). That frame can come
> from another node on the bus or from a local CAN_RAW socket.
>=20
> A frame with packet !=3D session->pkt.rx (for example, dat[0] =3D 1 sent
> repeatedly) does not advance pkt.rx:
>=20
> 	if (packet =3D=3D session->pkt.rx)
> 		session->pkt.rx++;
>=20
> It still sets remain, though, so this branch cancels and re-arms the 50m=
s
> txtimer and the 250ms rxtimer. The memcmp mismatch is only logged once.
>=20
> Suppose such a frame arrives at least every 50ms. The txtimer never fire=
s,
> so no data goes out. The rxtimer never fires either, so the session is n=
ever
> aborted. Later BAM transfers queued for that SA would hang behind it as
> well.
>=20
> Before this patch, the transmitter paced itself with its own txtimer, an=
d
> this branch ignored transmitter sessions.
>=20
> Should this branch re-arm only when the frame is the echo of the packet
> just sent (packet =3D=3D session->pkt.tx - 1), or when pkt.rx actually
> advanced?
>=20
This is also plausible, I can also add this check. Alternatively one=20
could also check if the skb is really an echo as is done in the can raw=20
implementation and only handle actual echo frames and discard frames=20
sent by other nodes.
> [Severity: Medium]
> Could this cancel then re-arm sequence leak session references if two DT
> frames for the same BAM session are processed at the same time?
>=20
> j1939_tp_schedule_txtimer() always takes a reference:
>=20
> 	j1939_session_get(session);
> 	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
> 		      HRTIMER_MODE_REL_SOFT);
>=20
> Nothing serialises j1939_xtp_rx_dat_one() calls for the same session.
> j1939_session_get_by_addr() holds active_session_list_lock only during t=
he
> lookup.
>=20
> Two CPUs could handle TP.DT frames for this session at once. One example=
 is
> the af_can loopback netif_rx() for a device without IFF_ECHO, racing a
> frame from the bus or an injected one. Another is two CAN_RAW injectors =
on
> vcan. The interleaving would be:
>=20
> CPU1                              CPU2
> j1939_session_txtimer_cancel()
>    hrtimer_cancel() =3D=3D 1, put
>                                    j1939_session_txtimer_cancel()
>                                      hrtimer_cancel() =3D=3D 0
> j1939_tp_schedule_txtimer()
>    j1939_session_get()
>    hrtimer_start()
>                                    j1939_tp_schedule_txtimer()
>                                      j1939_session_get()
>                                      hrtimer_start()
>=20
> When the timer fires, only one reference is dropped. The rxtimer has the
> same problem through j1939_tp_set_rxtimeout().
>=20
> A leaked session never reaches j1939_session_destroy(). Its j1939_priv
> reference and priv_dev_tracker netdev reference are then never released,
> and unregistering the CAN netdev would hang waiting for the device to
> become free.
>=20
> j1939_xtp_rx_cts_one() already uses the same unlocked pattern for direct=
ed
> sessions. Before this patch, though, the RX path never touched the txtim=
er
> for BAM transmitter sessions.
>=20
This also sounds plausible, how should this be fixed? Should additional=20
locks be added? The session list lock is probably not the correct one to=
=20
use as this is a global lock over all sessions.
Additionally is the same type of race condition then found in=20
j1939_tp_set_rxtimeout? It does basically the same thing and could also=20
be called concurrently while e.g. receiving a can frame and handling a=20
timer callback?

CPU 1 callstack:
j1939_tp_recv -> j1939_xtp_rx_dat -> j1939_xtp_rx_dat_one ->=20
j1939_tp_set_rxtimeout

CPU 2 callstack:
j1939_tp_txtimer -> j1939_xtp_txnext_transmiter -> j1939_session_tx_dat=20
-> j1939_tp_set_rxtimeout

Could this cause a similar leak as described above?

pw-bot: cr
