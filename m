Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678472;
	b=zHdd4sOamqUjM/EtP2GCKShMp1HZ6cgclxi6/Y8I/o6qk5hpuyeoFFO0Urqk7ar11jX4
	 OhPKiRcsGhglLUpjduaURqzEAL+2B5HXI4peYVXVB4GCeA1/b6J74kb1gzz4FdoPpXyLN
	 N3g62Lr/zJnLu0U20vFqOVnzNo8dDlRWTD0IK4AWQ23pzbrFJYfn6tHdovadif+zGC4EA
	 CgVsZNlhMXUOqp2YDOIRnetn+cVnRcrjtIHSmNiE3ueiUIOSmC+6wPjhlDABSkJ9AjxP+
	 cg7kAf1rrXvp2FTF17XcsXrcpyunKA5/hLlfidUebiU/+5nrg2LV9diBDUdSvPBQzpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678472;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Toe3fW/9OcEs91PQjKDA3fusgEgWleJga8wYfhw7eus=;
	b=dBz4xcjW9mQcfxLqZ3e6P64I+4CgU1+GDC1gucXIStQELd/BwNYzyTPXwaW7yOubZsN/
	 tMfeMJjH89VqTIDYAauLkcvZBo/V0Cgbt8yXI2jmaQJe70dBnmSVLDX/TeCppKeyeqga2
	 lFqnO1Hz27KiKAtwjRy6VnQdUrdGaUaKhPlBiWkOyZZuBGlm0h8ryh1dqP1eewXopCXkb
	 NUo6jku3BK2ugY+Jmrp0n+5GOwcPJEEr3cgax8ImcvJ/WxANY9Wv39RcdEmAaOAW8uwDQ
	 7Vgq8rchnddk0F3tIsPlwAMHyfH/8pdwrpcfAng4tXhdvTCajs33EJN/rc6rkzu2oJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=PlE4nS6A;
	arc=none smtp.remote-ip=212.27.42.1
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1AF606A319;
	Thu, 22 Oct 2026 14:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB1AF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=PlE4nS6A
Received: from stf-laptop (unknown [IPv6:2a02:8424:8fef:6e01:68ea:cb82:d40f:9275])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id B2E2DB0051B;
	Thu, 22 Oct 2026 16:14:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792678470;
	bh=Toe3fW/9OcEs91PQjKDA3fusgEgWleJga8wYfhw7eus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PlE4nS6Ai9CJdR5448FJ13bTPd0dPxoWoERcO3zNNdAIWKCEkUc4mSoICGTnibzmt
	 xsYSUoW2ursUOsavPFBYzfv3b0thood/rVSR5SWeawNkkawZx5qV29gPiA5gj0N9ej
	 iMPt4v+suy71mUypwqBqwXiSr4lhdlNDxoGkl73l8SnmBefur6l9uoRYpN23RgKaYh
	 MxIBYLDtYOkFIkb0D13CpkmfkMTpe0pbWLoxWPwvxl0dMFL73JboPB83PR10mHovTW
	 9uvRP26ymf30QZrRW8fFofhXgjGqfgFnmwxTSmMRYd4rFhZ7mmto/9kLchwYwrAIVm
	 p9Eaa+8s15Vww==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	error27@gmail.com,
	wg@grandegger.com,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH v5 08/10] can: peak_usb: reject records for unset channels in PCAN-USB Pro
Date: Thu, 22 Oct 2026 16:14:10 +0200
Message-ID: <20261022141410.222366-1-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179264019905.3131.17443314322038603114@kernel.org>
References: <20261020-canfd_check_channel_idx-v5-8-a62b35b867f0@peak-system.fr> <179264019905.3131.17443314322038603114@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 22/10/2026 05:36, netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Low]
> Should a well-formed record for an unset channel cause the rest of the
> transfer to be dropped?
[...]
> Would it be better to skip just this record, for example by returning 0?
> The same applies to the new check in pcan_usb_pro_handle_error().
>
> Later in the series, "can: peak_usb: register the netdevs only once all
> channels are set up" moves register_candev() into peak_usb_probe(),
> after all channels are initialized. That seems to make this branch
> unreachable by the end of the series.

Right, the rest of the transfer is dropped, as for the other malformed
records, and as patch 6 does for the PCAN-USB FD. I kept it that way on
purpose: as you note, patch 9 makes this branch unreachable, so this
only matters to a tree that would take this patch without patch 9. The
v6 changelog says so.

[...]
> [Severity: High]
> This is a pre-existing issue and was not introduced by this patch. Since
> this function is being changed anyway: can the payload memcpy() further
> down in pcan_usb_pro_handle_canmsg() read past the record and past the
> RX buffer?
[...]
> Could the code
> reject len > CAN_MAX_DLEN? It could also reject any length larger than
> the record format provides: 0 for RXMSG0 and RXRTR, 4 for RXMSG4, and 8
> for RXMSG8.

Confirmed. v6 adds a new patch, "can: peak_usb: validate the data
length of PCAN-USB Pro CAN records", which converts the DLC with
can_cc_dlc2len() and rejects a data frame whose length exceeds the
number of data bytes of its record type. Tested on a PCAN-USB Pro:
frames of all lengths are still received.

> [Severity: Medium]
> This isn't a bug introduced by this patch, but does the caller,
> pcan_usb_pro_decode_buf(), read pr->data_type before checking rec_ptr
> against msg_end?

Confirmed too, and pcan_usb_pro_wait_rsp() had the same issue, with a
32-bit record count and no bound at all. Another new patch in v6, "can:
peak_usb: don't read past the message in PCAN-USB Pro decoders", stops
both loops at the end of the received data.

[...]
> [Severity: High]
> This is a pre-existing issue and was not introduced by this patch, but
> can usb_if still be used after this kfree() for channel 0?
[...]
> Later in the series, "can: peak_usb: register the netdevs only once all
> channels are set up" removes register_candev() and the
> lbl_unregister_candev label from peak_usb_create_dev(). After that, no
> netdev can be open when adap_dev_free runs, which seems to fix this.

Agreed, this is fixed by patch 9 of the same series.

Thanks!

Stéphane
