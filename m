Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442702;
	b=GsIa4dTXjTnpfYI5pD2QHvzOvu/avj1tNs0uD50e2pexSeMiKkgKWH7+MJDXrFCEX/MK
	 B3A2zoH0y1BSQ8JrlVm6Xn3DvJjVSAPxvsTyPxvI5v0mP3BFV8LoVvHJiAp0YbIyU86tf
	 3WFcAgi30FKQRYayHv3PpwzaTm6uzaXJ4fCmNIL9RvMkfy9IAeWdNrKHFzDM5QoA+CilL
	 7GcqDxP4Br7jX5HQ95RL/qSS+v4BXW1cI9l/LJwD6rwrQzL3/AgmHG2tRR40Lqrekzlkn
	 P3sFIEi94RmeYXDkEZTkn+86/CKM+0DUe/dmSiW8NSfC4hxgl6bVkLYRG3Sihj0RMCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442702;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2Gxu410F0RGQQZvS1gwS5vMdAdSbGG5lKkmjMd4ZLtU=;
	b=X7CJCsLZNt4vE1DwYR91yGEZzJHX44MgoA0Bq8mnjCtDKAxxbTivtNIhUNJAUJ2aYGLk
	 KQFJ0YIJadpJW32PYYBYKZvHyN93EtKs0KEkNaq5qIgpKv2gqsy1jxagBP6qDCJu7gGsY
	 Nzm7m9rZFo4itfJ1Q7O/ApJ8EpkTUqM0jmxui3QFIcwDexdybhLYaaJbu9KsC4Vsf9mNA
	 YprkwuSnXa3dFPL5Kstpfsw4BrJaA5hk0jzouHfn52UBm0bxlkGkd5qJFpD+xqqvPPq7k
	 bAkKxaaa6iZ3Z+q0pbVOwAyZNRikk2EoF01lVtr5MiLw/c82sEASCBtKseQcKM+XmZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExxTbz57;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A5606A31C;
	Mon, 19 Oct 2026 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExxTbz57
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCF71F000C4;
	Mon, 19 Oct 2026 20:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792442701;
	bh=2Gxu410F0RGQQZvS1gwS5vMdAdSbGG5lKkmjMd4ZLtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ExxTbz57vAHZ6slPozXLwgdIYlqIGWP0EDQIt//l6ie0G8qRLTfv9oyeilU6qSQ2B
	 2AFgjOSejScGtFVjgvBkJsyd7MPb7p+Zm/wQP/Kxf9D91qcJ1EGuMwg7JJShI8k1LE
	 GlHC6yqWnfpte/USitmp9GNI45+nDZwBfSRZihvzCMBoVvNdwgFEp4/M7rbXvY+ZXe
	 IEoqNEoq0Xw3Q5eBpBvfZfwgHW/w++iOwhcTsISduQRnOcxSu66weejYHy6y9PkSWe
	 f9om5no3le0LKPfc4cNpBBtT/99+3Yy0tx15/Q+6fn1FrDpt855yzJb0vrzzRrV1LP
	 Su7b8B7hZfMhQ==
Date: Mon, 19 Oct 2026 13:45:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Filippo Storniolo <fstornio@redhat.com>,
 sashiko-reviews@lists.linux.dev, Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp
 <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v3 3/3] can: add can diag interface
Message-ID: <20261019134500.58a76643@kernel.org>
In-Reply-To: <20261017-delectable-mackerel-of-calibration-1fad6d-mkl@pengutronix.de>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
	<20260904-feat-can-diag-v3-3-bdcebf07b373@redhat.com>
	<20260904142606.6FB371F00A3D@smtp.kernel.org>
	<atJHPuFD8dZyoDaj@storniolo-redhat>
	<20261017-delectable-mackerel-of-calibration-1fad6d-mkl@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 12:10:21 +0200 Marc Kleine-Budde wrote:
> > I understand the concern, but as far as I can tell no other diag
> > handler implements this.  Does it make sense to add it only here rather
> > than as a follow-up done uniformly across all the diag handlers?
> >
> > @Marc Kleine-Budde @Oliver Hartkopp what do you think about this?
> > If you think it could be worth adding this feature, I can do a respin.  
> 
> Let's ask Jakub (Cc'ed), who is the author of these 2 files:
> 
> | Documentation/userspace-api/netlink/intro.rst
> | Documentation/core-api/netlink.rst

Sort of up to you, TBH. The AI loves to point this out,
but I think the fact most Netlink families don't handle
the inconsistency for 20 years almost proves that we're
fine without it?
