"""
Test the *_original_artist routines.

These tests are invoked by running `pytest` with the
appropriate options and environment variables, as
defined in `conftest.py`.
"""

# Standard libraries

# Installed packages
import pytest

# Local modules
import music


@pytest.fixture
def mserv(request, music_url, auth):
    return music.Music(music_url, auth)


@pytest.fixture
def song(request):
    # Recorded 1956
    return ('Elvis Presley', 'Hound Dog')


def test_simple_run(mserv, song):
    trc, m_id = mserv.create(song[0], song[1])
    assert trc == 200
    trc, artist, title = mserv.read(m_id)
    assert trc == 200 and artist == song[0] and title == song[1]
    mserv.delete(m_id)
    # No status to check
