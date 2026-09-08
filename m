Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1452FE41
	for <linux-can@vger.kernel.org>; Tue,  8 Sep 2026 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867726; cv=none; b=epQq/Hfnl9/FCBvNFCrL8xi8bAz5KVu+R4MpfuLqvKnnN5Tw2u6r2FkGAkrbVgf5e5HGqmoie4t33cTFZF0lf5hP/2nwhyggDte+EabiDEP/VwBidO3oVobgQiLZfCArkcLiGPMyToMvqRfEh/vNssIN6ha6wIlYqzULlsYyHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867726; c=relaxed/simple;
	bh=lKcZYANa2xZW6BHugzfwEBH9HbbHctpfxvit4Lo1/X8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bER2UhJ4LotwMvMqzzUhmjmDPu6oMijLp+6qigdVP2qUg+Wr5KmhkhXcvR1bsUTJ1mlslPdW2YoBFvu+f1lbIwmduSoriFDLdzV74RWxzTkMigfk7kRBr71+jBggIBh5uFNO8vXEnYZMe8wbXEfNSSUpi3tCp+dkImzsz9UE4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=V+LzkfR6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="V+LzkfR6"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so436672466b.1
        for <linux-can@vger.kernel.org>; Tue, 08 Sep 2026 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1788867720; x=1789472520; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lKcZYANa2xZW6BHugzfwEBH9HbbHctpfxvit4Lo1/X8=;
        b=V+LzkfR6Bg+B+hbk2q7gAR3KXE2NuzUAf6E8hY4ZGkkV+ZZle5APHwOQhZtawlq4Z6
         bOiw0Olgr92h82JlKICkKkGhxzD9E3EZD38UIYpNgIEZszCxyi0DA+8bK4hW0TVCtBwz
         ++M8NmeTJPm8p7Y1SAeg0LnEa613A2oF3NI+sQsYfgls0bvca1CrMlOig1VKLoBOq72k
         Wc9wtgS8nJ6G6R00tZbjg2sXpGPin1M2buLW2JJHq/C3BHMtIP4Ge2OmpAXbtNHwGNEh
         mi5qwsjO2qR5J7ihQYhLJMxVMD+dKYQW5OpdiCJbkJkKMO2aiMqwXyTTvm6Wg93zaY3Z
         iX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788867720; x=1789472520;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lKcZYANa2xZW6BHugzfwEBH9HbbHctpfxvit4Lo1/X8=;
        b=g4cp9oWgsRtSA2O72wFL9bXVaD3VVqn9Zbd8FuYhJRFKnOfsotz3b8Ic06VhKUsCah
         pOR7Im9ntAyHubJyGxTUnshG/fP84Y1KSaazJl0DnB6CrpliydbSF5HkUYKx5NeS6lCk
         sn8vNND7hNTxfeeDozoE1L/LdKNz3iU4Xo2Mh/N9B3/zsd6UoJ2lCSOZQS0yYKmpohY9
         lRn5xyqsSzTbMEBsaIcTBC1u736qnNDrBz8vs0n7hYSbb+gwb+YiNldZNkqjwtoa5Kac
         IgJivYeOzOYd5bKOz5L3cNH2vcQjhWTQIeSzkNxsFNTxQBwIEt5xkrHIM1qmoe1SAv+n
         wuIg==
X-Gm-Message-State: AFuF++nzEJ9b+YtaDI2X+9UZ0seh2xdctz+mvWH4zNOdvRtj+9j9bJ5T
	Lf2nPzEYnFANdD0TXadOJ32F4m6VGQCsBEdU2TIgJqVAztGZvbtqXV80+KapUy6PuJ9DuLWNbt5
	Q9LICcyM=
X-Gm-Gg: AYBFou0NFr8xoBIJZlaodKHMGOW1fTJbWKdyzXwkIx1VJYHPo7eiz8ipxqfeOTOLCKl
	fzKmuu4Vi9rzKs0GhgGqDhOGlqIRR1g3oilNBH3MNTkrly2V38Rjv+vv9L8XtHahZeXdVkj3+Nk
	tTpWCSMpRoq7sA0fvXAslUxvtpagfrp0a3xxeiN/FUGh5Tev9MYoqqAAIqvRdhyXlheOmfpsTgL
	yNhU+WU4sS7SKKPwY+qIGcX6Z3YS6Kp6C+s6Z5jyWOwg+shWSuggfG42mi4bJ95ozd2dZ5c9h6r
	Y8pZxJx+0X0rOi1boyTYLQbzcBF6ITl13dlYP6EASw1fjUdomlkwurUODiT3Ip1uIzk/b1ydj+g
	dvMjXAeZuwFN3xlehhB2kZINWagK9EKb9P1RukARWckMTukYa1WfFC1zDwjXC5fuSrEyN99T3Vt
	PRpaUDGAkydCQ3iFXTMl6ZjGclqH51MSHsMrQZf2x9Vu1Y6YtlrH8L6fv4JJ95JZ+DpqIxpyBcO
	52lTHarBk2/1GgjhHH+qt6BGZkxVS2EaKAZ1eNUbs/MupZ4mmOa
X-Received: by 2002:a17:907:6ea3:b0:c25:d03:6794 with SMTP id a640c23a62f3a-c260c9e7502mr1077896866b.16.1788867720196;
        Tue, 08 Sep 2026 04:42:00 -0700 (PDT)
Received: from smtpclient.apple (80.49.147.201.ipv4.supernova.orange.pl. [80.49.147.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c28e4579395sm342353366b.48.2026.09.08.04.41.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 04:41:59 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH v2] can: remove CAN filters independent from namespace
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <D4EEFE9E-284F-45F0-BF4E-39CFF7134E52@doyensec.com>
Date: Tue, 8 Sep 2026 13:41:47 +0200
Cc: linux-can@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE7A6380-97F7-46EE-9A45-026B60293DE0@doyensec.com>
References: <20260903065947.7718-1-socketcan@hartkopp.net>
 <D4EEFE9E-284F-45F0-BF4E-39CFF7134E52@doyensec.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: Apple Mail (2.3864.700.51.1.1)

Sorry, my mail client turned the address into a link and mangled the =
tag.
It should read:

Tested-by: Norbert Szetei <norbert@doyensec.com>

N.

> On Sep 8, 2026, at 1:34=E2=80=AFPM, Norbert Szetei =
<norbert@doyensec.com> wrote:
>=20
> Hi Oliver,
>=20
> many thanks for v2. I ran it on 7.3-rc2 with vcan and my reproducer no =
longer
> triggers. The ifindex case is gone too, from another namespace I can =
no longer
> touch a bound BCM socket.
>=20
> Tested-by: Norbert Szetei <norbert@doyensec.com =
<mailto:norbert@doyensec.com>>
>=20
> Thanks,
> Norbert
>=20
>> On Sep 3, 2026, at 8:59=E2=80=AFAM, Oliver Hartkopp =
<socketcan@hartkopp.net> wrote:
>>=20
>> When the devices namespace is changed the socket namespace and the =
device
>> namespace might differ. The net_eq(dev_net(dev), sock_net(sk)) check =
in
>> the CAN protocols netdev notifiers therefore led to skipping the =
required
>> removal of the CAN filters from the (namespace changed) CAN devices.
