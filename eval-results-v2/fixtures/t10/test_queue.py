from queue_lib import take

def main():
    assert take(2, ["a", "b", "c", "d"]) == ["a", "b"], "take(2) wrong"
    assert take(1, ["a", "b"]) == ["a"], "take(1) wrong"
    assert take(0, ["a"]) == [], "take(0) wrong"
    assert take(3, ["a", "b", "c", "d"]) == ["a", "b", "c"], "take(3) wrong"
    print("ALL TESTS PASSED")

if __name__ == "__main__":
    main()
