Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3043F08C;
	Thu,  1 Oct 2026 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868532; cv=none; b=S1+EZ4c/99hx7Z1kljy7Q94FxQc7R+GDD3qbynaEQ0Ow1HcOylE+6k8LQfhCkY4HNi1Ebg0wic+Mjv+gcWazAZycz2xnmYP1tnWMwIPqdAHcfajADs0vvOvwzjt2LcL+vNQGCYLX/cjb0YEaOT+7yRUKLw7SkDzdtEFchZoUwqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868532; c=relaxed/simple;
	bh=K5V+4/7y6C/8aieKYjMDr3wi6ymRCs/uoDyHSnFQM2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BS5bdnN9NXVEdgNqJT5bcvB+yHHcLgT/zVZ6u+UpFVYJMeWcRJ+HND1Ygmi5Ht3+z4i0IELvrjXTX+fHfoVxkI/JPfkHXipWYef2Svlo+ZGYDRPAWs9RCRJSHHntLbrAROmb6oO8CXb+fWBt6nY/rG2KVniiw9aRyXelqZaWcik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O00xxzTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O00xxzTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E52B1F000FF;
	Thu,  1 Oct 2026 15:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790868530;
	bh=oNofgzqxFuyu94E6P59dJHs9pZC5NzX0dR9jjsYcZL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O00xxzTmb5NIgP7BBWIjDbDYKKsZfuC9YRS7cuEi5q/NEK9nYZLOlFHYdrrFpxBm+
	 qVdGNXJhOSGhCy82Z0TowqteQoEKQyaItkGGVeWND9nDG4+elYqBmVulViCiDzj/KE
	 tdDQrT96+2HOzGm4UExzsqrVYgXwhbESBhmijkCAZoOWMswpCJe0Ci4UvQbZ7/eK3F
	 q8UothQLkzfZuYXYnSUTQTTs37fueIPfZKrNcekxn/N781+IZM4Qr6CRSJrGK9dMJw
	 62do+DBEnSSxqSuLZ2kbxhGkWug9Wfv3DRFAGFUfuxCqy/CoPnXtQIwllwL9+X4UpI
	 r1cmzRY9mzjgg==
Date: Thu, 1 Oct 2026 08:28:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
Message-ID: <20261001082850.754ca22f@kernel.org>
In-Reply-To: <20260929210700.1183036-1-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 22:43:50 +0200 Marc Kleine-Budde wrote:
> Hello netdev-team,
> 
> this is a pull request of 16 patches for net/main.

AFAIU there will be a respin here, and it's hitting:

net/can/bcm.c:944:2-12: WARNING: NULL check before (net)dev_{put, hold} functions is not needed.
net/can/bcm.c:1312:2-12: WARNING: NULL check before (net)dev_{put, hold} functions is not needed.

so dropping from PW.
