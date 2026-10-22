Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678318;
	b=yf92yG/wFZeLfTEnfuueacVU/bQPzUFGgr60rZlYpB2ZlxmIedfAqYXWdgsKODIS5qgg
	 QjBCt6tInaj15dBxuxdrG/SeBiHk+4cs9UQ/3GxvlLtFIh7DRFpzVcDN3wQEQz2kU+OT1
	 dx+DCXSKpqugZNC0FMuMAQkgiPRi2kdR5rb3eGoVAKHfME27ZOFYcYCYKydJxOV1z9RFb
	 z+hfMnGHeuUeijqKsZK5o3q3Ap5CbLmRIkL9hiEyfmyxJuq3QIm9ELGuikvq2J+K3kLoJ
	 Zsxh0tW9ZWVs+TTX/hnJfK7nb6FuLdOp5zLi92nCZZ4u/Wm0WVrbBwZQrQZJSpPIqow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678318;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MvlgLViOreb52RY6KLPY/X+KKSe10ZQuNkNnXVoW868=;
	b=KQgTapllqCJjfs+W74pWWeF5wHPo1VvbImqThhyIndDnbo/jHAkLN/iW4sxs7Ub0VZZx
	 OZ9whq+Bb/1dsmULQarFLjwphlXbOwWt/wRwfT3l3zVOpB4IbIVY+pngov0iuTP9KGmYQ
	 2I+psCPx2z3EpAzhS4Eg0zxod60W17T60nk1Oy3AqIjmVQ273zwomNt/4Zu2Tjd0DsC87
	 rLrNagUPkU1muJDSHLKx1WT7Ehb9wFanng4U54WZSoxkRj7ysi1/zrAt7J4hpjMW5oRN4
	 JyAiJArfd1wbSolbhU3h33JyZl+w5Og2kwDUuJMR8IyAVEG8LC2SrAUoFJJZ7Kl77Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b="DGUB/jg2";
	arc=none smtp.remote-ip=212.27.42.1
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E0B606A31B
	for <linux-can@vger.kernel.org>; Thu, 22 Oct 2026 14:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96E0B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=DGUB/jg2
Received: from stf-laptop (unknown [IPv6:2a02:8424:8fef:6e01:68ea:cb82:d40f:9275])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 0E7CEB00548;
	Thu, 22 Oct 2026 16:11:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792678305;
	bh=lZP9WK9rDpN4lz/28lm9o2dGeBCOUKpKi3EXOl1dIEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGUB/jg2hrLZHCfH0G8p+A3Ml6EcNWR5LspcUX9RNpoNHZhF3il2ca1Li5YwjoOJQ
	 MC64f7RZsNmIpFkMetdTVBPOe16Zc6Opu0knIXJVDeVTwmgjfS9T6dkcpzeRWB38Ad
	 Cz0iVgurB5SFWD8eMhVzpKleI09TIPZy9vV4LEo0ovItC331TNap7ba0GBrQ7jOFNU
	 l8wndQV52pinpqcOaFWqOI7sAIHxfwc9ETZCdUF5mabFkXkPTHolZ2JWP5zSSho7K0
	 ohL2NK0OhqNW3S9QsJ6mhfn0igmky42z0Z2+yvBwYfKpRvzDyygfINdYePBeM6P6Wj
	 B7Jcsi2XF5sMg==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v5 06/10] can: peak_usb: harden channel handling in PCAN-USB FD
Date: Thu, 22 Oct 2026 16:10:40 +0200
Message-ID: <20261022141039.220222-2-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-179109@kernel.org>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr> <20261020-canfd_check_channel_idx-v5-6-a62b35b867f0@peak-system.fr> <sashiko-outbox-179109@kernel.org>
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

On 20/10/2026 16:17, sashiko-bot@kernel.org wrote:
[...]
>> +static void peak_usb_stop_rx(struct peak_usb_device *dev)
>> +{
>> +	struct peak_usb_device *d;
>> +
>> +	for (d = dev; d; d = d->prev_siblings)
>> +		clear_bit(PCAN_USB_STATE_CONNECTED, &d->state);
>> +
>> +	for (d = dev; d; d = d->prev_siblings)
>> +		usb_poison_anchored_urbs(&d->rx_submitted);
>> +}
>
> [Severity: High]
> Can peak_usb_stop_rx() race with a concurrent peak_usb_ndo_open() and
> trigger a livelock in usb_poison_anchored_urbs() or leave the device open
> with all RX URBs killed?
[...]

Right, peak_usb_stop_rx() isn't serialized with peak_usb_ndo_open(), and
an RX URB anchored but not yet submitted makes usb_poison_anchored_urbs()
spin until peak_usb_start() submits or unanchors it.

v6 clears CONNECTED under rtnl_lock(), then poisons the anchors outside
of it. Since ndo_open() runs under RTNL, no ndo_open() can then be
between usb_anchor_urb() and usb_submit_urb() when the anchors are
poisoned, and any later one fails with -ENODEV. An ndo_open() that
completed before has submitted its URBs, which are then killed as
expected, since the device is going away anyway.

None of the callers (disconnect, probe error path) holds RTNL, and
disconnect already takes it afterwards through unregister_candev().

Thanks!

Stéphane
