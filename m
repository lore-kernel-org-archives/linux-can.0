Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4573161BA;
	Mon,  2 Mar 2026 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455836; cv=none; b=HvQd8gDo8a6NVDUiICks40oCKDKtTuLTpUAsTeuZRtja0IbgWxLjYeRZ8WP0wDy0FIV1yVaf4gcEBsksditDr/KBV/JzfvsQjcTXbONFi5MB6cFdWcJR1aHzikZWO903P1rlU2zYeyOXxJGXno4qT7UQs1LE9x1nUN37nxt4eQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455836; c=relaxed/simple;
	bh=DWp6FJVnAjPYvrbd7BtIqrt1Z2RnG99hZoQvyDO5j2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTVOiLmZC8hSjSpj74NisIJAkSwtUfx0nmpU/4z5cVpbMON5aFU+n6hbSTSJ2LXLYjG/fzs31Uq+jjydCxW8a7+zte21WaREQAtk0mAjyH2iNCbz2kRgOCWB4rjfEN3XjBRUwc8I6s8szgAL6XOqD+gb3yaQofRIUZEvNySmoh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LscGD1zW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LscGD1zW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0E7C19423;
	Mon,  2 Mar 2026 12:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772455836;
	bh=DWp6FJVnAjPYvrbd7BtIqrt1Z2RnG99hZoQvyDO5j2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LscGD1zWvDBtdp24eyAJEXiVNHzdmzt+QE5Mt3EeNTQVP/faW2ixk47Z0ShVDgffY
	 mt6mRyXvssxgOXf70tt+vaiqwx69OCAQeYQYuBgJDDkiOS1/DRlKvxa+8Z4zwCkvdg
	 Ji0EWgP2r1wzouOqI3SctNvTSEc+3IzXpSr5asS0=
Date: Mon, 2 Mar 2026 07:50:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Vincent Mailhol <mailhol@kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH 1/3] can: usb: f81604: handle short interrupt urb
 messages properly
Message-ID: <2026030218-goal-sandal-9a47@gregkh>
References: <2026022331-opal-evaluator-a928@gregkh>
 <20260302-steadfast-pony-of-glee-eef582-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-steadfast-pony-of-glee-eef582-mkl@pengutronix.de>

On Mon, Mar 02, 2026 at 11:08:21AM +0100, Marc Kleine-Budde wrote:
> On 23.02.2026 13:10:30, Greg Kroah-Hartman wrote:
> > If an interrupt urb is recieved that is not the correct length, properly
>                             ^^
> > detect it and don't attempt to treat the data as valid.
> >
> > Cc: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
> > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> > Cc: Vincent Mailhol <mailhol@kernel.org>
> > Cc: stable <stable@kernel.org>
> > Assisted-by: gkh_clanker_2000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Applied whole series to linux-can, with typo fix and preferred stable
> format.

Thanks!
