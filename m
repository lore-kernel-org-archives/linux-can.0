Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1326955D89D;
	Tue, 22 Sep 2026 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093816; cv=none; b=tOWP4Dr/ukWWEHLVgi827gbdExw/Jm2B5j9s/rBGJKtvA/ruBmKfN94Ks7IPJXmdcNXFp+cPbP78s/bGuF0hKooRDmbAMljWHHBxVAAHR2vbuwi+O6mZxX6KB72jME/SohfEs9ReXxhnnNGCCJvQ4pCkCT+OzWxZpcoQ3L6CVoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093816; c=relaxed/simple;
	bh=s6ATBbqYQd/98lyzGII8/bIJVeWjX/tXBnsGkzf/2Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bmlo0vTyyhOTU/vXY8WY0axppzgiIY2XfVUvzDuHWjngWAvg0wLQWsyUqNZJ6lTk8EM566qtnPz85rITeq2YoUE4jD9FGpQGn22S8azS4Pb1FVqjXTGw85Sex6R7DYjqG6C7FwUUa03ZepPgKV8i7tjdGir/wk05jsq9m4BL9wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwvo9Jjx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwvo9Jjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8467A1F000FF;
	Tue, 22 Sep 2026 16:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790093814;
	bh=D4s357HQCj5KMYVEFL11BM76HgLlHpRq7B+BhwoYgFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rwvo9JjxZftBGiGQMVjsWt16xhQ5FjkYXSTbpVM1B2rVfRpi0m8w/ScG8Bl5GsSsQ
	 FmEZElgQgVqEYIxnyBVVe4A7/yQ2wa26HkXM1ndCO2+b/rM2jgRSEQp0rNrBwD8PnY
	 h3N7TvLtMv35+PR69Y3e9ufQsmpbul9xiVNtrT0qZYPpAZmEuLRf2UIBkWw3zQ0ahY
	 iOhRnAVvMpLuXROi7BLHZPDWQiF8g5oRdGhnnxIug6rneoH4sT3Q42cGisgvLeZU6G
	 Q98VLyfao0m1vw6DRLQPyXv1sBpFdK+6ZxzRupo/0PLqMR1nX22+aNXedT4IwU5N1H
	 88tBxlOuIlSOQ==
Date: Tue, 22 Sep 2026 17:16:50 +0100
From: Simon Horman <horms@kernel.org>
To: Hui Peng <benquike@gmail.com>
Cc: robin@protonic.nl, o.rempel@pengutronix.de, mkl@pengutronix.de,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kernel@pengutronix.de, socketcan@hartkopp.net,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: j1939: fix transport session leak and socket
 bind/connect validation
Message-ID: <20260922161650.GG13925@horms.kernel.org>
References: <20260919223427.3881575-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919223427.3881575-1-benquike@gmail.com>

On Sat, Sep 19, 2026 at 10:34:27PM +0000, Hui Peng wrote:
> Fix two issues in net/can/j1939/:
> 
> 1. In j1939_tp_rxtimer() and session teardown
>    (net/can/j1939/transport.c), ensure active transport sessions and
>    skbs are properly cancelled and released on error or timeout.
> 2. In net/can/j1939/socket.c, validate socket state and address fields
>    consistently across bind/connect/sendmsg.

FWIIW, these changes look reasonable to me.
But I think you should make a short patch-set, with a cover letter
and two patch-sei - one patch per fix.

And I think the description needs to describe in a little more detail
what each bug is, and how it is fixed. While it doesn't need
to mention the filename, which is already present in the diff.

Thanks!
