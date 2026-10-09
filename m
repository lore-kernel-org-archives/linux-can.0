Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541E02F616B;
	Fri,  9 Oct 2026 01:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791507689; cv=none; b=cTypPbaDHZ41u6b8C8l//BpcGG/pVaVrGHPk06md0ZzzfGZjNvx2jKl6Uue/dZ+nzIwDjRUpdB3My/tkB0KjjD1XGPw/wXV2mxiCqi+R2GnPUQ4LlEeWTHfXRa+ie4JVYq8/3+66U2WWlhZFt3FbiBay0GTCWSbVEkpOmM1J4bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791507689; c=relaxed/simple;
	bh=Xec/MhEeCOfHgQc+9G6ao2G6XNN8az5QuPqoOqXVI84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Message-ID:Date:
	 Content-Type:MIME-Version; b=gnhvXIsoF0KzulMYW3rx+E34sOA7VRp3QcsDQsm1AF+gHU38Q3Rovmm3NFJt9A4HRs7kq5agAI7A/zivq4AaghLb2Qustnh7HRDLINA3zu9g+13UCKHzPDGdzLq5AJ+kgH1NMklP69I0p5l2T+ksL20VjtXo5iFG9ARSGYkbfSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BRjD11hY; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BRjD11hY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Message-ID:Date:Content-Type:
	MIME-Version; bh=74ZuU/s/mGZIs+ml8bbVpuKZc31nmz09CQD7GCgU12Y=;
	b=BRjD11hY3lR6BWHRvDEulMxTJxUAsJ4CZKQ/s+Ffm/Z5Au1L6T8d/WVYbnvbZU
	VShv04gV9iQoe2KZNhQ3efGimPpcQDQMll+636v6vL9gRrqiA188ab13MNvSiuzv
	QVTveyipNthXmDbYprAbJDBccEERF+hdk7PCMti014Z5g=
From: "Quchaosheng" <quchaosheng000406@163.com>
To: netdev-bot+sashiko@kernel.org
Cc: robin@protonic.nl, o.rempel@pengutronix.de, kernel@pengutronix.de,
 socketcan@hartkopp.net, mkl@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net v2 RESEND] can: j1939: validate the EDPO packet number
In-Reply-To: <179100326445.1406898.9460146166731761306@kernel.org>
References: <20260930055942.216879-1-quchaosheng000406@163.com>
 <179100326445.1406898.9460146166731761306@kernel.org>
Message-ID: <179150765233.22689.7239412530475901049@163.com>
Date: Fri, 09 Oct 2026 09:00:52 +0800
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:_____wAHvrzEPMhqN6RrDQ--.17S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF45GrWUXr1xWr4rZF1rCrg_yoW5ZFW3pF
	W5KryjkrnrtFWFyr1xJa4DXFWFyw1aqryfX3yUJ34Iyw45CFWayF9xKrWxuasrGrs5u3yY
	9a1UXwn8Jw1vvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRku4bUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5AUNgmrIPMXy9gAA3x

On Sat, 03 Oct 2026, netdev-bot+sashiko@kernel.org wrote:

> Critical: 0 - High: 0 - Medium: 2 - Low: 1 (1)
>
> - [Medium] The commit message says the transmitter role is unaffected by
>   the new check: "a transmitter derives the offset from pkt.tx_acked,...
> - [Medium] The new EDPO abort branch in j1939_xtp_rx_dpo_one() calls
>   j1939_session_timers_cancel() and then j1939_session_cancel() without...

Thanks for the review. One of the two Medium items is a real problem with
my commit message and one I believe is a false positive. Details below.

On the first one: you are right and my summary was wrong. I wrote that a
transmitter derives the offset from pkt.tx_acked, which is "cts_packet - 1"
with cts_packet <= pkt.total, so the largest value it ever announces is
pkt.total - 1. Nothing in j1939_xtp_rx_cts_one() enforces that bound. The
only checks there are:

	if (!pkt)
		goto out_session_cancel;
	else if (dat[1] > session->pkt.block)
		goto out_session_cancel;

	session->pkt.tx_acked = pkt - 1;

and for ETP pkt comes from (dat[4] << 16) | (dat[3] << 8) | dat[2], so a
peer can set tx_acked past pkt.total. The clamp a few lines further down
only bounds pkt.last:

	if (session->pkt.last > session->pkt.total)
		session->pkt.last = session->pkt.total;

tx_acked is left as received. So the sentence about the transmitter role
does not hold on what the code does today, and I will drop it rather than
try to prop it up. Whether j1939_xtp_rx_cts_one() should also reject
pkt > pkt.total is a separate question from this patch, and I would send
that as its own change rather than fold it in here.

On the second one I think the code is fine, but here is what I based it on
rather than just asserting it. j1939_xtp_rx_dpo_one() is called from
j1939_xtp_rx_dpo(), which takes the session with
j1939_session_get_by_addr() and always does j1939_session_put() on the way
out:

	j1939_xtp_rx_dpo_one(session, skb);
	j1939_session_put(session);

So returning early from the abort branch drops the reference the caller
took and there is no leak. Cancelling the timers before calling
j1939_session_cancel() is the same order the existing out_session_cancel
label in j1939_xtp_rx_cts_one() uses.

What I do not think is needed here is j1939_session_deactivate(). The
session is being aborted, not parked for reuse, and j1939_session_cancel()
already moves it out of the active range before scheduling the abort:

	if (session->state >= J1939_SESSION_ACTIVE &&
	    session->state < J1939_SESSION_WAITING_ABORT) {
		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
		__j1939_session_cancel(session, err);
	}

If you have a specific invariant in mind that deactivate() maintains on
this path, say which one and I will add the call. I would rather not add
it on a guess.

On the Low item about the commit message: fair, that sentence describes
the reproduction I ran before the range check existed and reads as a claim
about the patch. I will split the two so it is clear the NULL guard and
the DPO range check are separate steps and neither is presented as
sufficient on its own.

I will send a v3 with the commit message reworded so it no longer claims
something the CTS path does not enforce.

pw-bot: cr

