Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F794475322;
	Thu,  1 Oct 2026 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790878805; cv=none; b=d+bDWXP3a6fuJGtSlXqy1lVbwqnpJu6sSfGLq7XKX6n5OJ6TZU7MEEFPwq4IpP4xrKb7TlWRlIjV+71niPyDcD6m/CfnHJzVPujKCpV6lnoxW4FjZDQ01rb7/LRb6ZEkSDvVEzNQTIsYsc7Bv608oIdJMR2xQv5Y/oPqZ6+li6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790878805; c=relaxed/simple;
	bh=Xm3WcnzL28++8GnNByuNi3mwrcwr+VSG1bS5gCTtKms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8+Jtdk6FTX/8UCVR8tVodG1syfSBptr9uoxllXNOy0p2z0DV3b3+1fBkKNNxQ7DisAEdznLuNIHvcu7sX4pbAINFQ0m+nTp6YLyjwR7ycP7kkU25ZKugSTLcqJvJEmGTDQlqDQUYJ9IeZDjU0RcNUL9qhCkR3r4fHCQX/Cm87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwALh+K8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwALh+K8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CAF1F00898;
	Thu,  1 Oct 2026 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790878795;
	bh=kMrLVJoKOZaH95MksnbSoaYhZXEbTDWEJu7vsxVqczo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PwALh+K8Xp5ag5KmAsp26+FkhLh55rOqqbMr8+a7dSJKIhBvgwm2isBcUqQ6e+k1w
	 h5qx+7zGgIy6IhPsyrGBv6Lbv+3Y9aBYrdrgnrSWr9MbEUHyXKBqUOnrDQNJMwzFsq
	 3guBaLd9ds10DKWxtfU20ywvR/VjYYKBEv/Nwc5c525TBdF4GvikIkhimqonEmDocB
	 5BP5lAfy6QqirrDbX0mc6NTKrAPk+gEU+Kml9srubmSgP+APiQ887hv/k8W6ij4kBc
	 QLkuGt6VdMaQiMDMT1/imoPgCgVjMTEoqnW4Got7kCNwOhXVgcujP3rAhxPFp5dExP
	 QmtVx0vRwSPxQ==
Date: Thu, 1 Oct 2026 11:19:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, ore@pengutronix.de, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, davem@davemloft.net,
 linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
Message-ID: <20261001111954.2ebaf14c@kernel.org>
In-Reply-To: <20261001-portable-mastodon-of-dignity-380136-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
	<9956662e-6001-413d-864d-d8d048a93819@redhat.com>
	<cb83d0dc-58a4-4262-99a0-1e4478630ba0@hartkopp.net>
	<19ab3d46-f326-4f08-a161-d31ae272a9d8@redhat.com>
	<e4a05f3a-7206-4fe4-b04f-bf2a9f1fb926@hartkopp.net>
	<20261001-fascinating-clam-of-plenty-5307a0-mkl@pengutronix.de>
	<20261001082552.514c54fd@kernel.org>
	<20261001-portable-mastodon-of-dignity-380136-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 17:38:17 +0200 Marc Kleine-Budde wrote:
> On 01.10.2026 08:25:52, Jakub Kicinski wrote:
> > > Don't know Oleksij has done the sashiko.dev integraton.  
> >
> > Let me try to plug you into netdev-ai one for now.  
> 
> Thanks, do you need anything from us?

I don't think so, we already had the setup for the old AIR system.
The emails should start flowing in a day or two. Please let me know
if you don't see any review out by Monday!
