Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795300940;
	b=zwIAbW4b7MxmcZwyZ/gFUMma9PrBoYkqD40Slx9BI7ngkwiuRcvnbLN13n/2FIU43oJV
	 +rFALmzzREL9FXB6H+YhnCV/Uw6V/MIxCj+kC//LOZQ2LuwPaqbG3zEKrEZ9nzr7sWPo2
	 BkgvyxmdnN8r+SMI0ox7mcqto0AVqwuQKtMRJn0/tG7NKYBWQnJuAznNrZIz+oMULf8+o
	 lDVi6Cw+DWh1An+EQi+xeVy7VUzTGiQomLdZPKcYaCQU46EX08qvqfiPQXE66e37veM+m
	 syYvNbuM3ZjWOrms2k1IPEg+H1pNmlfHAuLOO/YMrR8jkBFdA43ATgn+zSt85dk9JjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300940;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RZoSDjYGaXgpnaXMw1hGkzk9j5Iy3B+9aSIYFv9Zg5c=;
	b=PtxAQvBwbSqJNaeF63hfow1Ha9Ek2CbPh39cp5J57W6mvsBeOa6GV+qscaFthuyWOgQe
	 0D2K077Wfud7aD/+m59S3w1UWS6NVaYJIbHylc10tNyh+lj8W1Ab7B6gQTVQfBmub0Q+W
	 mnwuwJmhX/l5YRgTb3fIei60YbcGidcnvj5nnSfsq+jD2lNqkCpa4f2SsQY9eT0gZF5xQ
	 gambXLZKbEvvR2yZLcDlnHcNbmMwWdqg5z7SK18n40Ij+YuO8Z2Vot+9hOKfjaSjI8wuZ
	 T9EvSUIwd7qYVOotU0s5lrLp+I7SqLALml4UAKYdEzgGzzzYPp3LGaxS33aA/gMTkeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENogarfQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B1606A32A
	for <linux-can@vger.kernel.org>; Sat, 21 Nov 2026 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENogarfQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D479D1F000C0;
	Sat, 21 Nov 2026 22:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300940;
	bh=RZoSDjYGaXgpnaXMw1hGkzk9j5Iy3B+9aSIYFv9Zg5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ENogarfQw+n+lj/Ida5iuXXthEp4gVd7nM0PJSeh8iLkhw82Y9N6Y+LMg/xungO15
	 82a3l8GrwP5k+5BWJAvhZl79oNifP5nqh0rDPZIusub5Ke2t155tYS4XgZ8NS9BF9j
	 JUpKWwb+DcMnDLs9kRplqpmT4a6b1Qr9ol/tX7cGSSwR2MjrmrHbmiowrAPMkVzMQX
	 ekTDhY4b9uSdVIZ+fqfRfXXCkupgl4EwPfBsLDwbx6Q8erB7+nVjDb1u/pVYBZegA6
	 soWvUI6j98vO/BvkkN3C5ujIZtB4ltzP0sz+8OwgKjBjjI0BiLHlrxf95GJYiAoxjV
	 atKXfnY1CDmXA==
Message-ID: <sashiko-outbox-227457@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next v9 08/13] can: gs_usb:
 gs_usb_receive_bulk_callback(): use dev_info() to print re-submit info
 messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-8-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
 <20261121-gs_usb-fixes-v9-8-db121d488945@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 22:42:19 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] can: gs_usb: redundant double rate limiting in
  gs_usb_receive_bulk_callback()
--

commit 6963c253f83fff9fd057f286e4568b102a31d71f
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: gs_usb: gs_usb_receive_bulk_callback(): use dev_info() to print re-sub=
mit info messages

This commit replaces netdev_info() with dev_info_ratelimited() when
logging IN URB resubmission failures in gs_usb_receive_bulk_callback() so
that the affected USB device is reported even when netdev has not been
identified yet.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 308daa2645ada..f49179cbd7876 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
[ ... ]
> @@ -820,8 +820,9 @@ static void gs_usb_receive_bulk_callback(struct urb *=
urb)
>  				netif_device_detach(parent->canch[rc]->netdev);
>  		}
>  	} else if (rc !=3D -ESHUTDOWN && net_ratelimit()) {
> -		netdev_info(netdev, "failed to re-submit IN URB: %pe\n",
> -			    ERR_PTR(rc));
> +		dev_info_ratelimited(&parent->udev->dev,
> +				     "failed to re-submit IN URB: %pe\n",
> +				     ERR_PTR(rc));
>  	}
>  }

[Severity: Low]
Should net_ratelimit() be dropped from the condition now that
dev_info_ratelimited() is used?  Keeping both applies two independent
rate limiters and consumes tokens from the global net_ratelimit_state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-gs_usb-fix=
es-v9-0-db121d488945@pengutronix.de?part=3D8
